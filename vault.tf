variable "consul_encrypt_key" {}
variable "do_token" {}
variable "ssh_key_path" {}

provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_ssh_key" "root_ssh" {
  name = "Terraform Root SSH Key"
  public_key = "${file(var.ssh_key_path)}"
}

module "do_consul" {
  source = "./consul"
  region = "nyc2"
  count = 3

  ssh_key_id = "${digitalocean_ssh_key.root_ssh.id}"
  consul_encrypt_key = "${var.consul_encrypt_key}"
}

module "do_vault" {
  source = "./vault"
  region = "nyc2"
  count = 2

  ssh_key_id = "${digitalocean_ssh_key.root_ssh.id}"
  consul_address = "${module.do_consul.leader}"
  consul_encrypt_key = "${var.consul_encrypt_key}"
}
