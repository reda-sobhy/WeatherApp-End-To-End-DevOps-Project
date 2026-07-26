region = "us-east-1"
vpc_cidr = "10.0.0.0/16"

azs = [
  "us-east-1a",
  "us-east-1b"
]

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnet_cidrs = [
  "10.0.3.0/24",
  "10.0.4.0/24"
]


cluster_name = "my-eks"

node_instance_type = "t3.small"

desired_capacity = 2
min_size         = 2
max_size         = 4

db_password = "StrongPassword123!"
