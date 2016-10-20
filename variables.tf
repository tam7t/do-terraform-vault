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

variable "vault_version" {
  description = "The version of vault to run"
  default     = "0.6.2"
}
