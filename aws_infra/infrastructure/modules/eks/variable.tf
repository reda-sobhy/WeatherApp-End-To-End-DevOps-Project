variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}



variable "vpc_id" {
  type        = string
  description = "VPC ID for the cluster"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Public subnet IDs for the eks cluster"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for the nodes"
}

variable "node_instance_type" {
  type    = string
  default = "t3.medium"
  description = "EC2 instance type for nodes"
}

variable "desired_capacity" {
  type    = number
  default = 2
  description = "Desired number of worker nodes"
}

variable "min_size" {
  type    = number
  default = 2
  description = "Minimum number of worker nodes"
}

variable "max_size" {
  type    = number
  default = 4
  description = "Maximum number of worker nodes"
}

