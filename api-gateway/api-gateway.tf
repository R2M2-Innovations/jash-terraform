data "template_file" "aws_api_gateway_policy" {
  template = file(
    "policies/${var.organization}-${var.application}-${var.environment}-${var.stack_id}.tpl"
  )
  vars = {
    account = var.account
    region = var.region
  }
}

data "template_file" "open_api_spec" {
  template = file("apis/${var.organization}-${var.application}-${var.environment}-${var.stack_id}.json")
  vars = {
    description = "${var.organization}-${var.application}-${var.environment}-${var.stack_id}"
    organization = var.organization
    application = var.application
    environment = var.environment
    stack_id = var.stack_id
    version = var.deployment_version
    policy = data.template_file.aws_api_gateway_policy.rendered
  }
}

resource "time_sleep" "delay_destroy_120s" {
  destroy_duration = "120s"
}

resource "aws_api_gateway_rest_api" "api_gateway_rest_api" {
  name        = "${var.organization}-${var.application}-${var.environment}-${var.stack_id}"
  description = "${var.organization}-${var.application}-${var.environment}-${var.stack_id}"
  endpoint_configuration {
    types = [ var.type ]
  }
  body = data.template_file.open_api_spec.rendered
  depends_on = [
    time_sleep.delay_destroy_120s
  ]
}

resource "aws_api_gateway_deployment" "api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_rest_api.id
}

resource "aws_api_gateway_stage" "api_gateway_stage" {
  count = length(var.stages)
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_rest_api.id
  deployment_id = aws_api_gateway_deployment.api_gateway_deployment.id
  stage_name    = var.stages[count.index] 
  description = var.stage_variables[var.stages[count.index]]["description"]
  documentation_version = var.stage_variables[var.stages[count.index]]["documentation_version"]
  cache_cluster_enabled = var.stage_variables[var.stages[count.index]]["cache_cluster_enabled"]
  cache_cluster_size = var.stage_variables[var.stages[count.index]]["cache_cluster_size"]
  client_certificate_id = var.stage_variables[var.stages[count.index]]["client_certificate_id"]
  variables = var.stage_variables[var.stages[count.index]]["variables"]
  xray_tracing_enabled = var.stage_variables[var.stages[count.index]]["xray_tracing_enabled"]
  tags = merge(local.common_tags)
  depends_on = [
    time_sleep.delay_destroy_120s
  ]
}

module "api_gateway" {
  source                  = "../modules/cloudwatch/api-gateway"
  monitoring              = var.monitoring
  alarm_notification_arns = var.alarm_notification_arns
  ok_notification_arns    = var.ok_notification_arns
  api_name = "${var.organization}-${var.application}-${var.environment}-${var.stack_id}"
}
