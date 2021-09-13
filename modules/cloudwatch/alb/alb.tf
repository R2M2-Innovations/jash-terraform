variable "monitoring" {
  default = true
  description = "enable or disable monitoring"
}

variable "evaluation_periods" {
  default     = 3
  description = "cloudwatch monitoring evaluation periods"
}

variable "period" {
  default     = 120
  description = "cloudwatch monitoring interval (sec)"
}

variable "alarm_notification_arns" {
  description = "sns alarm notification arns"
}

variable "ok_notification_arns" {
  description = "sns alarm notification arns"
}

variable "alb_arn_suffix" {
  description = "alb arn suffix"
}

variable "target_group_arn_suffix" {
  description = "target group arn suffix"
}

resource "aws_cloudwatch_metric_alarm" "alb_unhealthy_host_count" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.target_group_arn_suffix}-alb-unhealthy-hosts"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "3"
  metric_name               = "UnHealthyHostCount"
  namespace                 = "AWS/ApplicationELB"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "1"
  alarm_description         = "This metric monitors ALB unhealthy host count"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.alarm_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "breaching"
  dimensions = {
    LoadBalancer = var.alb_arn_suffix
    TargetGroup  = var.target_group_arn_suffix
  }
}

resource "aws_cloudwatch_metric_alarm" "alb_500_errors" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.alb_arn_suffix}-alb-unhealthy-hosts"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "3"
  metric_name               = "HTTPCode_ELB_5XX_Count"
  namespace                 = "AWS/ApplicationELB"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1" 
  alarm_description         = "This metric monitors ALB 500 error count"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.alarm_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    LoadBalancer = var.alb_arn_suffix
  }
}

resource "aws_cloudwatch_metric_alarm" "alb_tls_errors" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.alb_arn_suffix}-alb-tls-errors"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "3"
  metric_name               = "ClientTLSNegotiationErrorCount"
  namespace                 = "AWS/ApplicationELB"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1" 
  alarm_description         = "This metric monitors ALB client TLS error count"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.alarm_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    LoadBalancer = var.alb_arn_suffix
  }
}

resource "aws_cloudwatch_metric_alarm" "alb_rejected_connections" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.alb_arn_suffix}-alb-rejected-connections"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "3"
  metric_name               = "RejectedConnectionCount"
  namespace                 = "AWS/ApplicationELB"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "This metric monitors ALB rejected connections count"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.alarm_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    LoadBalancer = var.alb_arn_suffix
  }
}

resource "aws_cloudwatch_metric_alarm" "alb_target_500_errors" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.target_group_arn_suffix}-alb-target-500-errors"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "3"
  metric_name               = "HTTPCode_Target_5XX_Count"
  namespace                 = "AWS/ApplicationELB"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "This metric monitors ALB target 500 error count"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.alarm_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    LoadBalancer = var.alb_arn_suffix
    TargetGroup  = var.target_group_arn_suffix
  }
}

resource "aws_cloudwatch_metric_alarm" "alb_target_connection_errors" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.target_group_arn_suffix}-alb-target-connection-errors"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "3"
  metric_name               = "TargetConnectionErrorCount"
  namespace                 = "AWS/ApplicationELB"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1" 
  alarm_description         = "This metric monitors ALB target connection error count"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.alarm_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    LoadBalancer = var.alb_arn_suffix
    TargetGroup  = var.target_group_arn_suffix
  }
}

resource "aws_cloudwatch_metric_alarm" "alb_target_tls_errors" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.target_group_arn_suffix}-alb-target-tls-errors"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "3"
  metric_name               = "TargetTLSNegotiationErrorCount"
  namespace                 = "AWS/ApplicationELB"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "This metric monitors ALB target TLS error count"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.alarm_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    LoadBalancer = var.alb_arn_suffix
    TargetGroup  = var.target_group_arn_suffix
  }
}

