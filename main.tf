provider "aws" {
  region = var.aws_region
}

locals {
  tags = {
    project     = "thevpnbeast"
    responsible = "infra"
    versioning  = var.versioning_enabled
    encryption  = var.encryption_enabled
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket        = var.bucket_name
  force_destroy = true
  tags          = local.tags
}

resource "aws_s3_bucket_acl" "acl_configuration" {
  bucket = aws_s3_bucket.terraform_state.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption_configuration" {
  count  = var.encryption_enabled ? 1 : 0
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "versioning_configuration" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Disabled"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  count        = var.lock_table_enabled ? 1 : 0
  name         = var.lock_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
