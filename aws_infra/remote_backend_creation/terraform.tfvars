# ================= S3 Bucket =================

terraform_state_bucket_name = "weatherapp-state"

terraform_state_bucket_tags = {
  Name        = "Terraform State Bucket"
  Environment = "Production"
  ManagedBy   = "Terraform"
}


# ================= S3 Versioning =================

terraform_state_versioning_status = "Enabled"


# ================= Encryption =================

terraform_state_sse_algorithm = "AES256"


# ================= Public Access =================

terraform_state_public_access_block = {
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


# ================= DynamoDB Lock =================

terraform_state_lock_table_name = "terraform-state-lock"

terraform_state_lock_billing_mode = "PAY_PER_REQUEST"

terraform_state_lock_hash_key = "LockID"

terraform_state_lock_tags = {
  Name        = "Terraform State Lock Table"
  Environment = "Production"
  ManagedBy   = "Terraform"
}
