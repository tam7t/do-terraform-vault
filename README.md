# do-terraform-vault
A [terraform](https://www.terraform.io/) script for setting up [vault](https://vaultproject.io/) on DigitalOcean.

# About
This script creates a block storage device to hold the vault data and runs the
official vault docker image on a CoreOS droplet.

# Usage

# terraform
* Supply all necessary variables to a `.tfvars` file
* `terraform get`
* `terraform plan -var-file=vault.tfvars`
* `terraform apply -var-file=vault.tfvars`
* `terraform destroy -var-file=vault.tfvars`

## vault
* `VAULT_ADDR=http://<vault ip address>:8200 vault init`

From here, read the [vault docs](https://vaultproject.io/docs/index.html)
