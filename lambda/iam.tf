data "template_file" "iam-policy-template" {
  template = file(
    "templates/${var.organization}-${var.application}-${var.environment}-${var.stack_id}-iam-policy.tpl",
  )
  vars = { 
    account      = var.account
    region       = var.region
    organization = var.organization
    application  = var.application
    environment  = var.environment
    stack_id     = var.stack_id
  }
}

resource "aws_iam_role" "iam-role" {
  name = "${var.organization}-${var.application}-${var.environment}-${var.stack_id}-lambda"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {   
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },  
      "Effect": "Allow",
      "Sid": ""
    }   
  ]
}
EOF
}

resource "aws_iam_role_policy" "iam-role-policy" {
  name   = "${var.organization}-${var.application}-${var.environment}-${var.stack_id}-role-policy"
  role   = aws_iam_role.iam-role.id
  policy = data.template_file.iam-policy-template.rendered
}
