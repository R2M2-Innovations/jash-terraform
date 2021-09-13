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

variable "function_name" {
  description = "function name"
}

variable "errors" {
  default     = 0
  description = "invocation errors"
}

variable "throttles" {
  default     = 0
  description = "throttled invocations"
}

variable "duration" {
  default     = 3
  description = "function execution time"
}

resource "aws_cloudwatch_metric_alarm" "errors" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.function_name}-errors"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.evaluation_periods
  metric_name               = "Errors"
  namespace                 = "AWS/Lambda"
  period                    = var.period
  statistic                 = "Average"
  threshold                 = var.errors
  alarm_description         = "This metric monitors Lambda function invocation errors"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    FunctionName = var.function_name
  }
}

resource "aws_cloudwatch_metric_alarm" "throttles" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.function_name}-throttles"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.evaluation_periods
  metric_name               = "Throttles"
  namespace                 = "AWS/Lambda"
  period                    = var.period
  statistic                 = "Average"
  threshold                 = var.throttles
  alarm_description         = "This metric monitors Lambda function throttled invocations"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    FunctionName = var.function_name
  }
}

resource "aws_cloudwatch_metric_alarm" "duration" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.function_name}-duration"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.evaluation_periods
  metric_name               = "Duration"
  namespace                 = "AWS/Lambda"
  period                    = var.period
  statistic                 = "Average"
  threshold                 = var.duration
  alarm_description         = "This metric monitors Lambda function execution duration"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    FunctionName = var.function_name
  }
}
