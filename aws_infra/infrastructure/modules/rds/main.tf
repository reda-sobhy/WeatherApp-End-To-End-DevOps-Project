resource "aws_db_subnet_group" "this" {

  name = "${var.name}-subnet-group"

  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.name}-subnet-group"
  }
}

resource "aws_security_group" "this" {

  name        = "${var.name}-rds-sg"
  description = "Allow database traffic"
  vpc_id      = var.vpc_id


  ingress {
    description = "MySQL access"

    from_port = 3306
    to_port   = 3306

    protocol = "tcp"

    security_groups = [
      var.allowed_security_group_id
    ]
  }


  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }


  tags = {
    Name = "${var.name}-rds-sg"
  }
}



resource "aws_db_instance" "this" {


  identifier = var.name


  engine = var.engine


  engine_version = var.engine_version


  instance_class = var.instance_class



  allocated_storage = var.storage



  db_name = var.database_name


  username = var.username


  password = var.password



  db_subnet_group_name = aws_db_subnet_group.this.name


  vpc_security_group_ids = [
    aws_security_group.this.id
  ]



  multi_az = var.multi_az



  publicly_accessible = false



  storage_encrypted = true



  backup_retention_period = 0



  skip_final_snapshot = true



  deletion_protection = false



  tags = {

    Name = var.name

  }

}
