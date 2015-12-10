backend "consul" {
  address = "localhost:8500"
  path = "vault"
  tls_ca_file = "/etc/consul/ca.pem"
  tls_cert_file = "/etc/consul/cert.pem"
  tls_key_file = "/etc/consul/key.pem"
}

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_cert_file = "/etc/vault/cert.pem"
  tls_key_file = "/etc/vault/key.pem"
}

# telemetry {
#  statsite_address = "127.0.0.1:8125"
#  disable_hostname = true
# }
