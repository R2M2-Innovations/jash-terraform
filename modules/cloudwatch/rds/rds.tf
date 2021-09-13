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

variable "rds_instance_id" {
  description = "rds instance id to monitor"
}

variable "rds_cpu_utilization" {
  default = 95
  description = "rds instance cpu utilization"
}

variable "rds_memory_utilization" {
  default = 500000000
  description = "rds instance memory utilization"
}

variable "rds_free_storage" {
  default = 100000000
  description = "rds instance free storage"
}

variable "rds_read_latency" {
  default = 0.015
  description = "rds instance read latency"
}

variable "rds_write_latency" {
  default = 0.015
  description = "rds instance write latency"
}

resource "aws_cloudwatch_metric_alarm" "rds_cpu_utilization" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.rds_instance_id}-rds-cpu-utilization"
  alarm_description         = "This metric monitors RDS instance CPU utilization"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/RDS"
  statistic                 = "Average"
  period                    = "300"
  evaluation_periods        = "3"
  threshold                 = "95"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    Name  = "DBInstanceIdentifier"
    Value = var.rds_instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_memory_utilization" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.rds_instance_id}-rds-memory-utilization"
  alarm_description         = "This metric monitors RDS instance memory utilization"
  metric_name               = "FreeableMemory"
  namespace                 = "AWS/RDS"
  statistic                 = "Average"
  period                    = "300"
  evaluation_periods        = "3"
  threshold                 = "500000000"
  comparison_operator       = "LessThanOrEqualToThreshold"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    Name  = "DBInstanceIdentifier"
    Value = var.rds_instance_id
  }
}


resource "aws_cloudwatch_metric_alarm" "rds_free_storage" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.rds_instance_id}-rds-free-storage"
  alarm_description         = "This metric monitors RDS free storage space"
  metric_name               = "FreeStorageSpace"
  namespace                 = "AWS/RDS"
  statistic                 = "Average"
  period                    = "300"
  evaluation_periods        = "3"
  threshold                 = "100000000"
  comparison_operator       = "LessThanOrEqualToThreshold"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    Name  = "DBInstanceIdentifier"
    Value = var.rds_instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_read_latency" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.rds_instance_id}-rds-read-latency"
  alarm_description         = "This metric monitors RDS read latency"
  metric_name               = "ReadLatency"
  namespace                 = "AWS/RDS"
  statistic                 = "Average"
  period                    = "300"
  evaluation_periods        = "3"
  threshold                 = "0.015"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    Name  = "DBInstanceIdentifier"
    Name  = "DBInstanceIdentifier"
    Value = var.rds_instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_write_latency" {
  count = var.monitoring ? 1 : 0
  alarm_name = "${var.rds_instance_id}-rds-write-latency"
  alarm_description         = "This metric monitors RDS write latency"
  metric_name               = "WriteLatency"
  namespace                 = "AWS/RDS"
  statistic                 = "Average"
  period                    = "300"
  evaluation_periods        = "3"
  threshold                 = "0.015"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    Name  = "DBInstanceIdentifier"
    Value = var.rds_instance_id
  
  }
}
