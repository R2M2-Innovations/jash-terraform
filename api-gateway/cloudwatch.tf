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

variable "api_name" {
  default     = "null"
  description = "api gateway name"
}

variable "http_4xxerrors" {
  default     = "null"
  description = "http 4xx errors"
}

variable "http_5xxerrors" {
  default     = "null"
  description = "http 5xx errors"
}

variable "latency" {
  default     = "null"
  description = "api gateway total latency"
}

variable "integration_latency" {
  default     = "null"
  description = "api gateway integration latency"
}

