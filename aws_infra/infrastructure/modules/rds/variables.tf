variable "name" {

  type = string

}


variable "vpc_id" {

  type = string

}



variable "subnet_ids" {

  type = list(string)

}



variable "allowed_security_group_id" {

  type = string

}



variable "engine" {

  default = "mysql"

}



variable "engine_version" {

  default = "8.0"

}



variable "instance_class" {

  default = "db.t3.micro"

}



variable "storage" {

  default = 20

}



variable "database_name" {

  type = string

}



variable "username" {

  type = string

}



variable "password" {

  type = string

  sensitive = true

}



variable "multi_az" {

  default = false

}
