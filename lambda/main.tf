resource "aws_lambda_function" "lambda-function" {
  function_name     = "${var.organization}-${var.application}-${var.environment}-${var.stack_id}"
  filename          = (var.source_type == "file" ? var.source_file : null)
  s3_bucket         = (var.source_type == "s3" ? var.source_s3_bucket : null)
  s3_key            = (var.source_type == "s3" ? var.source_s3_key : null)
  s3_object_version = (var.source_type == "s3" && var.source_s3_object_version != "" ? var.source_s3_object_version : null)
  role              = aws_iam_role.iam-role.arn
  handler           = var.handler 
  runtime           = var.runtime 
  memory_size       = var.memory_size
  timeout           = var.timeout

  environment {
    variables = var.env_vars
  }
  
  tracing_config {
    mode = (var.trace == "true" ? "Active" : "PassThrough")
  }

  vpc_config {
    subnet_ids          = var.vpc_subnet_ids
    security_group_ids  = var.vpc_security_groups
  }

  publish = var.publish

  tags = merge(local.common_tags)
}

module "lambda" {
  source                  = "../modules/cloudwatch/lambda"
  monitoring              = var.monitoring
  alarm_notification_arns = var.alarm_notification_arns
  ok_notification_arns    = var.ok_notification_arns
  function_name           = aws_lambda_function.lambda-function.id
  duration                = var.timeout
}
