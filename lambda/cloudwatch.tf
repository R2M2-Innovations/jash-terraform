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

variable "function_name" {
  default     = "null"
  description = "lambda function name"
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
