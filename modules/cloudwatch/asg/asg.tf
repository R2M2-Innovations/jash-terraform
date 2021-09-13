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

variable "asg_name" {
  description = "asg name"
}

variable "autoscaling_group_in_service_threshold" {
  default = 1
  description = "asg instances in service"
}

variable "autoscaling_group_pending_threshold" {
  default = 0
  description = "asg instances in pending state"
}

variable "autoscaling_group_terminating_threshold" {
  default = 0
  description = "asg instances in terminating state"
}

resource "aws_cloudwatch_metric_alarm" "asg_group_in_service_instances" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.asg_name}-in-service"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = var.evaluation_periods
  metric_name               = "GroupInServiceInstances"
  namespace                 = "AWS/AutoScaling"
  period                    = var.period
  statistic                 = "Average"
  threshold                 = var.autoscaling_group_in_service_threshold
  alarm_description         = "This metric monitors ASG in service instances"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
}

resource "aws_cloudwatch_metric_alarm" "asg_group_pending_instances" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.asg_name}-pending"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.evaluation_periods
  metric_name               = "GroupPendingInstances"
  namespace                 = "AWS/AutoScaling"
  period                    = var.period
  statistic                 = "Average"
  threshold                 = var.autoscaling_group_pending_threshold
  alarm_description         = "This metric monitors ASG instances in pending state"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
}

resource "aws_cloudwatch_metric_alarm" "asg_group_terminating_instances" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.asg_name}-terminating"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.evaluation_periods
  metric_name               = "GroupTerminatingInstances"
  namespace                 = "AWS/AutoScaling"
  period                    = var.period
  statistic                 = "Average"
  threshold                 = var.autoscaling_group_terminating_threshold
  alarm_description         = "This metric monitors ASG instances in terminating state"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
}
