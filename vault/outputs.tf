output "addresses" {
  value = "${join(",", digitalocean_droplet.server.*.ipv4_address)}"
}

output "leader" {
  value = "${digitalocean_droplet.server.0.ipv4_address}"
}
