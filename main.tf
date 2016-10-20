provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_ssh_key" "root_ssh" {
  name       = "Terraform vault SSH Key"
  public_key = "${trimspace(file(var.ssh_key_path))}"
}

resource "digitalocean_volume" "data" {
  region      = "${var.region}"
  name        = "vault-data"
  size        = "${var.volume_size}"
  description = "data volume to hold vault"
}

data "template_file" "cloudinit" {
  template = "${file("${path.module}/templates/cloudinit.tpl")}"

  vars {
    volume_name = "${digitalocean_volume.data.name}"
    version     = "${var.vault_version}"
  }
}

resource "digitalocean_droplet" "droplan-coreos" {
  image              = "${var.image}"
  name               = "droplan-coreos"
  region             = "${var.region}"
  size               = "${var.size}"
  private_networking = false
  ssh_keys           = ["${digitalocean_ssh_key.root_ssh.id}"]
  volume_ids         = ["${digitalocean_volume.data.id}"]

  user_data = "${data.template_file.cloudinit.rendered}"
}
