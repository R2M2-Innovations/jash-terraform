resource "aws_api_gateway_domain_name" "api_gateway_domain_name" {
  count = var.custom_domains == "true" ? length(var.stages) : 0
  domain_name = var.stage_variables[var.stages[count.index]]["domain_config"]["domain_name"]
  regional_certificate_arn = var.stage_variables[var.stages[count.index]]["domain_config"]["certificate"]

  endpoint_configuration {
    types = [var.type]
  }
  tags = merge(local.common_tags)
}

resource "aws_route53_record" "route53_record" {
  count = var.custom_domains == "true" ? length(var.stages) : 0
  name    = aws_api_gateway_domain_name.api_gateway_domain_name[count.index].domain_name
  type    = "A"
  zone_id = var.stage_variables[var.stages[count.index]]["domain_config"]["zone_id"]

  alias {
    evaluate_target_health = true
    name                   = aws_api_gateway_domain_name.api_gateway_domain_name[count.index].regional_domain_name
    zone_id                = aws_api_gateway_domain_name.api_gateway_domain_name[count.index].regional_zone_id
  }
}

resource "time_sleep" "delay_create_120s" {
  create_duration = "120s"
  depends_on = [
    aws_api_gateway_rest_api.api_gateway_rest_api,
    aws_api_gateway_domain_name.api_gateway_domain_name
  ]
}

resource "aws_api_gateway_base_path_mapping" "api_gateway_base_path_mapping" {
  count = var.custom_domains == "true" ? length(var.stages) : 0
  api_id      = aws_api_gateway_rest_api.api_gateway_rest_api.id
  stage_name  = var.stages[count.index]
  domain_name = aws_api_gateway_domain_name.api_gateway_domain_name[count.index].domain_name
  depends_on = [
    time_sleep.delay_create_120s
  ]
}
