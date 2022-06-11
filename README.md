# AWS S3 State Bucket Module
[![CI](https://github.com/vpnbeast/state-bucket-terraform/workflows/CI/badge.svg?event=push)](https://github.com/vpnbeast/state-bucket-terraform/actions?query=workflow%3ACI)

Terraform module which creates state bucket on S3 and dynamodb lock table if configured. Please see [MODULE.md](MODULE.md) for module documentation.

## Usage
You can use below module configuration in your terraform configuration:
```
module "s3-state-bucket" {
  source                    = "git::https://github.com/vpnbeast/state-bucket-terraform.git"
  bucket_name               = "thevpnbeast-terraform-states"
  versioning_enabled        = true
  encryption_enabled        = true
  lock_table_enabled        = false
}
```