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

variable "ebs_volume_count" {
  default = 0 
  description = "number of ebs volumes to monitor"
}

variable "ebs_volume_ids" {
  type = list
  default = [] 
  description = "ebs volume ids to monitor"
}

variable "ebs_queue_length_threshold" {
  default = 1
  description = "ebs volume queue length"
}

variable "ebs_volume_read_latency_threshold" {
  default = 15000
  description = "ebs volume read latency threshold"
}

variable "ebs_volume_write_latency_threshold" {
  default = 15000
  description = "ebs volume write latency threshold"
}

variable "ebs_volume_throughput_threshold" {
  default = 90 
  description = "ebs volume throughput threshold"
}

resource "aws_cloudwatch_metric_alarm" "ebs_volume_queue_length" {
  count  = var.ebs_volume_count * (var.monitoring ? 1 : 0)
  alarm_name = join("-", [ element(var.ebs_volume_ids, count.index), "queue-length"])
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.evaluation_periods
  metric_name               = "VolumeQueueLength"
  namespace                 = "AWS/EBS"
  period                    = var.period
  statistic                 = "Average"
  threshold                 = var.ebs_queue_length_threshold
  alarm_description         = "This metric monitors EBS volume queue length"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    VolumeId = element(var.ebs_volume_ids, count.index)
  }
}

resource "aws_cloudwatch_metric_alarm" "ebs_volume_read_latency" {
  count  = var.ebs_volume_count * (var.monitoring ? 1 : 0)
  alarm_name = join("-", [ element(var.ebs_volume_ids, count.index), "read-latency"])
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = var.evaluation_periods
  metric_name               = "VolumeTotalReadTime"
  namespace                 = "AWS/EBS"
  period                    = var.period
  statistic                 = "Average"
  threshold                 = var.ebs_volume_read_latency_threshold
  alarm_description         = "This metric monitors EBS volume read latency"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    VolumeId = element(var.ebs_volume_ids, count.index)
  }
}

resource "aws_cloudwatch_metric_alarm" "ebs_volume_write_latency" {
  count  = var.ebs_volume_count * (var.monitoring ? 1 : 0)
  alarm_name = join("-", [ element(var.ebs_volume_ids, count.index), "write-latency"])
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = var.evaluation_periods
  metric_name               = "VolumeTotalWriteTime"
  namespace                 = "AWS/EBS"
  period                    = var.period
  statistic                 = "Average"
  threshold                 = var.ebs_volume_write_latency_threshold
  alarm_description         = "This metric monitors EBS volume write latency"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    VolumeId = element(var.ebs_volume_ids, count.index)
  }
}

resource "aws_cloudwatch_metric_alarm" "ebs_volume_throughput_threshold" {
  count  = var.ebs_volume_count * (var.monitoring ? 1 : 0)
  alarm_name = join("-", [ element(var.ebs_volume_ids, count.index), "throughput-percentage"])
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = var.evaluation_periods
  metric_name               = "VolumeThroughputPercentage"
  namespace                 = "AWS/EBS"
  period                    = var.period
  statistic                 = "Average"
  threshold                 = var.ebs_volume_throughput_threshold
  alarm_description         = "This metric monitors EBS volume provisioned IOPS utilization percentage"
  alarm_actions             = [ var.alarm_notification_arns ]
  ok_actions                = [ var.ok_notification_arns ]
  insufficient_data_actions = [ var.alarm_notification_arns ]
  treat_missing_data        = "notBreaching"
  dimensions = {
    VolumeId = element(var.ebs_volume_ids, count.index)
  }
}

resource "null_resource" "ebs_cli_commands" {
  count  = var.ebs_volume_count
  provisioner "local-exec" {
    command = "echo"
  }
}
