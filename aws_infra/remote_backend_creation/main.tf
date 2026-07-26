# ================= S3 Terraform State Bucket =================

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.terraform_state_bucket_name

  tags = var.terraform_state_bucket_tags
}


# ================= Enable Versioning =================

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = var.terraform_state_versioning_status
  }
}


# ================= Server Side Encryption =================

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.terraform_state_sse_algorithm
    }
  }
}


# ================= Block Public Access =================

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = var.terraform_state_public_access_block.block_public_acls
  block_public_policy     = var.terraform_state_public_access_block.block_public_policy
  ignore_public_acls      = var.terraform_state_public_access_block.ignore_public_acls
  restrict_public_buckets = var.terraform_state_public_access_block.restrict_public_buckets
}


# ================= DynamoDB State Lock =================

resource "aws_dynamodb_table" "terraform_state_lock" {

  name         = var.terraform_state_lock_table_name
  billing_mode = var.terraform_state_lock_billing_mode
  hash_key     = var.terraform_state_lock_hash_key

  attribute {
    name = var.terraform_state_lock_hash_key
    type = "S"
  }

  tags = var.terraform_state_lock_tags
}
