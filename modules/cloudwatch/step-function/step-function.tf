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
  description = "function_name"
}

variable "executions_timed_out" {
  default     = 0
  description = "executions timed out"
}

variable "executions_failed" {
  default     = 0
  description = "executions failed"
}

variable "executions_throttled" {
  default     = 0
  description = "executions throttled"
}


resource "aws_cloudwatch_metric_alarm" "executions-timed-out" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.function_name}-executions-timed-out"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.evaluation_periods
  metric_name               = "ExecutionsTimedOut"
  namespace                 = "AWS/States"
  period                    = var.period
  statistic                 = "Average"
  threshold                 = var.executions_timed_out
  alarm_description         = "This metric monitors Step Function executions time out"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    FunctionName = var.function_name
  }
}

resource "aws_cloudwatch_metric_alarm" "executions-failed" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.function_name}-executions-failed"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.evaluation_periods
  metric_name               = "ExecutionsFailed"
  namespace                 = "AWS/States"
  period                    = var.period
  statistic                 = "Average"
  threshold                 = var.executions_failed
  alarm_description         = "This metric monitors Step Function executions failed"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    FunctionName = var.function_name
  }
}

resource "aws_cloudwatch_metric_alarm" "executions-throttled" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.function_name}-executions-throttled"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.evaluation_periods
  metric_name               = "ExecutionsThrottled"
  namespace                 = "AWS/States"
  period                    = var.period
  statistic                 = "Average"
  threshold                 = var.executions_throttled
  alarm_description         = "This metric monitors Step Function executions throttled "
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    FunctionName = var.function_name
  }
}
