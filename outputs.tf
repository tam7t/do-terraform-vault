output "vault-address" {
  value = "${digitalocean_droplet.droplan-coreos.ipv4_address}"
}

output "volume-id" {
  value = "${digitalocean_volume.data.id}"
}
