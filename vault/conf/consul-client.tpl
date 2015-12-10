{
  "advertise_addr": "ADDR",
  "start_join":["${consul_address}"],
  "server": false,
  "datacenter": "${dc}",
  "data_dir": "/var/consul",
  "encrypt": "${encrypt}",
  "cert_file": "/etc/consul/cert.pem",
  "key_file": "/etc/consul/key.pem",
  "ca_file": "/etc/consul/ca.pem",
  "verify_incoming": true,
  "verify_outgoing": true,
  "log_level": "INFO",
  "enable_syslog": true
}
