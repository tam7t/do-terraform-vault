resource "digitalocean_droplet" "server" {
  image = "${var.image}"
  count = "${var.count}"
  name = "${var.role}-${var.region}-${count.index}"
  region = "${var.region}"
  size = "${var.size}"
  ssh_keys = ["${var.ssh_key_id}"]

  provisioner "remote-exec" {
    inline = [
      "apt-get update",
      "apt-get upgrade -y",
      "apt-get install -y unzip"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "cd /tmp",
      "wget https://releases.hashicorp.com/consul/0.5.2/consul_0.5.2_linux_amd64.zip",
      "unzip consul_0.5.2_linux_amd64.zip -d /usr/local/bin",
      "chmod +x /usr/local/bin/consul",
      "rm /tmp/consul_0.5.2_linux_amd64.zip",
      "mkdir /etc/consul",
      "chmod a+w /etc/consul"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "useradd -ms /bin/bash consul",
      "mkdir /var/consul",
      "chown consul:consul /var/consul"
    ]
  }

  # Would much rather 'template_file' be a provisioner instead of a resource.
  # This terrible hack is used to avoid a cycle
  provisioner "remote-exec" {
    inline = [
      "echo '${replace(template_file.consul.rendered, "ADDR", self.ipv4_address)}' > /etc/consul/config.json"
    ]
  }

  provisioner "file" {
    source = "${path.module}/conf/upstart-consul.conf"
    destination = "/etc/init/consul.conf"
  }

  provisioner "remote-exec" {
    inline = "sudo start consul || sudo restart consul"
  }
}

resource "template_file" "consul" {
  template = "${file("${path.module}/conf/consul-server.tpl")}"

  vars {
    encrypt = "${var.consul_encrypt_key}"
    dc = "${var.region}"
    count = "${var.count}"
  }
}

# On the first consul server we will 'join' all other consul servers
resource "null_resource" "bootstrap_consul" {
  provisioner "remote-exec" {
    inline = "consul join ${join(" ", digitalocean_droplet.server.*.ipv4_address)}"
    connection = {
      user = "root"
      host = "${digitalocean_droplet.server.0.ipv4_address}"
    }
  }
}
