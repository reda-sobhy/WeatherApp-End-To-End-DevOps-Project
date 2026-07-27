resource "aws_secretsmanager_secret" "this" {
  name = var.secret_name
}

resource "aws_secretsmanager_secret_version" "this" {

  secret_id = aws_secretsmanager_secret.this.id

  secret_string = var.secret_value

}

resource "aws_iam_policy" "secret_read" {

  name = "${var.secret_name}-read-policy"


  policy = jsonencode({

    Version = "2012-10-17"


    Statement = [

      {

        Effect = "Allow"


        Action = [

          "secretsmanager:GetSecretValue"

        ]


        Resource = aws_secretsmanager_secret.this.arn

      }

    ]

  })

}

resource "aws_iam_role" "this" {


  name = "${var.secret_name}-role"


  assume_role_policy = jsonencode({

    Version = "2012-10-17"


    Statement = [

      {

        Effect = "Allow"


        Principal = {

          Federated = var.oidc_provider_arn

        }


        Action = "sts:AssumeRoleWithWebIdentity"


Condition = {
  StringEquals = {
    "${var.oidc_provider}:sub" : "system:serviceaccount:${var.namespace}:${var.service_account_name}"
  }
}
      }

    ]

  })

}


resource "aws_iam_role_policy_attachment" "this" {


  role = aws_iam_role.this.name


  policy_arn = aws_iam_policy.secret_read.arn


}


