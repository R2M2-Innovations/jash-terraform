variable "monitoring" {
  default = true
  description = "enable cloudwatch monitoring"
}

variable "evaluation_periods" {
  default = 3
  description = "cloudwatch monitoring evaluation periods"
}

variable "period" {
  default = 120
  description = "cloudwatch monitoring interval (sec)"
}

variable "alarm_notification_arns" {
  description = "sns alarm notification arns"
}

variable "ok_notification_arns" {
  description = "sns alarm notification arns"
}

variable "api_name" {
  description = "api_name"
}

variable "http_4xxerrors" {
  default     = 0
  description = "http 4xx errors"
}

variable "http_5xxerrors" {
  default     = 0
  description = "http 5xx errors"
}

variable "latency" {
  default     = 15000
  description = "api gateway total latency"
}

variable "integration_latency" {
  default     = 15000
  description = "api gateway integration latency"
}

resource "aws_cloudwatch_metric_alarm" "api-gateway-4xxerrors" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.api_name}-4xxerrors"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.evaluation_periods
  metric_name               = "4XXError"
  namespace                 = "AWS/ApiGateway"
  period                    = var.period
  statistic                 = "Sum"
  threshold                 = var.http_4xxerrors
  alarm_description         = "This metric monitors API Gateway 4xx errors"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    APIName = var.api_name
  }
}

resource "aws_cloudwatch_metric_alarm" "api-gateway-5xxerrors" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.api_name}-5xxerrors"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.evaluation_periods
  metric_name               = "5XXError"
  namespace                 = "AWS/ApiGateway"
  period                    = var.period
  statistic                 = "Sum"
  threshold                 = var.http_5xxerrors
  alarm_description         = "This metric monitors API Gateway 5xx errors"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    APIName = var.api_name
  }
}

resource "aws_cloudwatch_metric_alarm" "api_gateway_total_latency" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.api_name}-total-latency"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.evaluation_periods
  metric_name               = "Latency"
  namespace                 = "AWS/ApiGateway"
  period                    = var.period
  statistic                 = "Sum"
  threshold                 = var.latency
  alarm_description         = "This metric monitors API Gateway total latency"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    APIName = var.api_name
  }
}

resource "aws_cloudwatch_metric_alarm" "api_gateway_integration_latency" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.api_name}-integration-latency"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.evaluation_periods
  metric_name               = "IntegrationLatency"
  namespace                 = "AWS/ApiGateway"
  period                    = var.period
  statistic                 = "Sum"
  threshold                 = var.integration_latency
  alarm_description         = "This metric monitors API Gateway integration latency"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    APIName = var.api_name
  }
}
