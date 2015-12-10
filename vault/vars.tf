variable "role" { default="vault" }
variable "image" { default="ubuntu-14-04-x64" }
variable "count" { default=2 }
variable "region" { default="nyc2" }
variable "size" { default="8gb" }
variable "ssh_key_id" {}
variable "consul_address" {}
variable "consul_encrypt_key" {}
variable "ca_file" {}
variable "consul_cert_file" {}
variable "consul_key_file" {}
variable "vault_cert_file" {}
variable "vault_key_file" {}
