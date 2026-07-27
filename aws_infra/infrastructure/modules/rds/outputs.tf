output "endpoint" {

  value = aws_db_instance.this.endpoint

}



output "port" {

  value = aws_db_instance.this.port

}



output "database_name" {

  value = aws_db_instance.this.db_name

}



output "security_group_id" {

  value = aws_security_group.this.id

}
output "mysql_address" {
  value = aws_db_instance.this.address
}
