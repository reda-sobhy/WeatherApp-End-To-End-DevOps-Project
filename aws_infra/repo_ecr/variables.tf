variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "repository_name" {
  description = "ECR Repository Name"
  type        = string
}

variable "image_tag_mutability" {
  description = "Image tag mutability"
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Enable image scanning"
  type        = bool
  default     = true
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"
}
