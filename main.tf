terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5"
    }
  }
}

provider "aws" {
  region = var.aws_region
  profile = var.aws_profile
  dynamic "assume_role" {
    for_each = var.assume_role_arn != null ? [1] : []
    content {
      role_arn     = var.assume_role_arn
      session_name = "Terraform"
    }
  }
  default_tags {
    tags = merge(var.aws_default_tags, {
      "Terraform" = "true"
      "TF_MODULE_REPO" = "https://github.com/katunch/tf_aws_account_initializer"
    })
  }
}

# Add an S3 Bucket for Terraform State
resource "aws_s3_bucket" "state_bucket" {
  bucket = "${var.reverse_fqdn}.terraform"
}
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.state_bucket.bucket
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.state_bucket.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
resource "aws_s3_bucket_public_access_block" "publicBlock" {
  bucket                  = aws_s3_bucket.state_bucket.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Create a DynamoDB Table for Terraform State Locking
resource "aws_dynamodb_table" "state_lock" {
  name                        = "${var.reverse_fqdn}.terraform"
  billing_mode                = "PAY_PER_REQUEST"
  table_class                 = "STANDARD_INFREQUENT_ACCESS"
  deletion_protection_enabled = true
  hash_key                    = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

# Create a Route 53 Hosted Zone
resource "aws_route53_zone" "zone" {
  name = var.fqdn
}