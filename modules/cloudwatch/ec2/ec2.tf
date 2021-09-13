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

variable "ec2_instance_id" {
  description = "ec2 instance ids to monitor"
}

variable "ec2_instance_status_check" {
  default = 0
  description = "ec2 instance status check"
}

variable "ec2_system_status_check" {
  default = 0
  description = "ec2 system status check"
}

variable "ec2_instance_cpu_threshold" {
  default = 95
  description = "ec2 instance cpu threshold"
}

resource "aws_cloudwatch_metric_alarm" "ec2_instance_status_check" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.ec2_instance_id}-instance-status-check"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.evaluation_periods
  metric_name               = "StatusCheckFailed_Instance"
  namespace                 = "AWS/EC2"
  period                    = var.period
  statistic                 = "Average"
  threshold                 = var.ec2_instance_status_check
  alarm_description         = "This metric monitors EC2 instance status check failures"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "breaching"
  dimensions = {
    InstanceId = var.ec2_instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "ec2_system_status_check" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.ec2_instance_id}-system-status-check"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.evaluation_periods
  metric_name               = "StatusCheckFailed_System"
  namespace                 = "AWS/EC2"
  period                    = var.period
  statistic                 = "Average"
  threshold                 = var.ec2_system_status_check
  alarm_description         = "This metric monitors EC2 system status check failures"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "breaching"
  dimensions = {
    InstanceId = var.ec2_instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "ec2_instance_cpu_utilization" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.ec2_instance_id}-cpu-utilization"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.evaluation_periods
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = var.period
  statistic                 = "Average"
  threshold                 = var.ec2_instance_cpu_threshold
  alarm_description         = "This metric monitors EC2 instance CPU utilization "
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    InstanceId = var.ec2_instance_id
  }
}
