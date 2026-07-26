# ================= S3 Terraform State Bucket =================

variable "terraform_state_bucket_name" {
  description = "Name of the S3 bucket used for Terraform state"
  type        = string
}

variable "terraform_state_bucket_tags" {
  description = "Tags for Terraform state S3 bucket"
  type        = map(string)
  default     = {}
}


# ================= S3 Versioning =================

variable "terraform_state_versioning_status" {
  description = "Enable or disable S3 bucket versioning"
  type        = string
  default     = "Enabled"
}


# ================= S3 Encryption =================

variable "terraform_state_sse_algorithm" {
  description = "Server side encryption algorithm for S3 bucket"
  type        = string
  default     = "AES256"
}


# ================= S3 Public Access Block =================

variable "terraform_state_public_access_block" {
  description = "S3 public access block configuration"

  type = object({
    block_public_acls       = bool
    block_public_policy     = bool
    ignore_public_acls      = bool
    restrict_public_buckets = bool
  })

  default = {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }
}


# ================= DynamoDB State Lock =================

variable "terraform_state_lock_table_name" {
  description = "DynamoDB table name for Terraform state locking"
  type        = string
}


variable "terraform_state_lock_billing_mode" {
  description = "DynamoDB billing mode"
  type        = string
  default     = "PAY_PER_REQUEST"
}


variable "terraform_state_lock_hash_key" {
  description = "DynamoDB partition key"
  type        = string
  default     = "LockID"
}


variable "terraform_state_lock_tags" {
  description = "Tags for DynamoDB lock table"
  type        = map(string)
  default     = {}
}
