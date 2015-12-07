# do-terraform-vault
A simple terraform setup for bootstrapping a vault cluster on DigitalOcean.

*Do not use this in production, see the [vulnerabilities](#Vulnerabilities) section below.*

# About
This terraform script bootstraps a [consul](https://www.consul.io/) back [vault](https://vaultproject.io/) cluster configured in [High Availability](https://vaultproject.io/docs/internals/high-availability.html) mode.

# Usage

## Building the cluster
* Supply all necessary variables to a `.tfvars` file
* `terraform get`
* `terraform plan -var-file=vault.tfvars`
* `terraform apply -var-file=vault.tfvars`
* `terraform destroy -var-file=vault.tfvars`

## Using vault
* `VAULT_ADDR=http://<vault ip address>:8200 vault init`

From here, read the [vault docs](https://vaultproject.io/docs/index.html)

# Vulnerabilities
* While the consul cluster's gossip is protected by a shared secret, the RPC mechanism is left open
* Vault is configured to run on HTTP so all operations are MITM-able
