variable "consul_encrypt_key" {}
variable "do_token" {}
variable "ssh_key_path" {}
variable "ca_file" {}
variable "consul_cert_file" {}
variable "consul_key_file" {}
variable "vault_cert_file" {}
variable "vault_key_file" {}

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
  ca_file = "${var.ca_file}"
  consul_cert_file = "${var.consul_cert_file}"
  consul_key_file = "${var.consul_key_file}"
}

module "do_vault" {
  source = "./vault"
  region = "nyc2"
  count = 2

  ssh_key_id = "${digitalocean_ssh_key.root_ssh.id}"
  consul_address = "${module.do_consul.leader}"
  consul_encrypt_key = "${var.consul_encrypt_key}"
  ca_file = "${var.ca_file}"
  consul_cert_file = "${var.consul_cert_file}"
  consul_key_file = "${var.consul_key_file}"
  vault_cert_file = "${var.vault_cert_file}"
  vault_key_file = "${var.vault_key_file}"
}
