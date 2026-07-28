module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}


module "eks" {
  source = "./modules/eks"

  cluster_name = var.cluster_name

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids  = module.vpc.public_subnet_ids

  node_instance_type = var.node_instance_type

  desired_capacity = var.desired_capacity
  min_size         = var.min_size
  max_size         = var.max_size

}


module "rds" {

  source = "./modules/rds"

  name = "app-db"

  vpc_id = module.vpc.vpc_id

  subnet_ids = module.vpc.private_subnet_ids

allowed_security_group_id = module.eks.cluster_security_group_id
  database_name = "app"

  username = "admin"

  password = var.db_password

  instance_class = "db.t3.micro"

  multi_az = true

}


module "db_secret" {


source = "./modules/secrets_manager"



secret_name = "weather-db-v4"



secret_value = jsonencode({

 username = "admin"

 password = var.db_password

  host = module.rds.mysql_address

 database = "weather"

})



oidc_provider_arn = module.eks.oidc_provider_arn
oidc_provider = module.eks.cluster_oidc_issuer_url





namespace = "backend"



  service_account_name = "weather-app-sa"


}
