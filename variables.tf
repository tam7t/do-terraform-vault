variable "do_token" {}

variable "ssh_key_path" {}

variable "region" {
  default = "nyc1"
}

variable "size" {
  default = "512mb"
}

variable "image" {
  default = "coreos-stable"
}

variable "volume_size" {
  default = "10"
}
