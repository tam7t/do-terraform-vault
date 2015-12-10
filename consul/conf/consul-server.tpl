{
  "bootstrap_expect": ${count},
  "advertise_addr": "ADDR",
  "server": true,
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
