output "secret_name" {

 value = aws_secretsmanager_secret.this.name

}


output "secret_arn" {

 value = aws_secretsmanager_secret.this.arn

}


output "role_arn" {

 value = aws_iam_role.this.arn

}
