variable "region" {
  description = "aws region"
}

variable "organization" {
  description = "organization name"
}

variable "environment" {
  description = "environment e.g. dev, qa, prod"
}

variable "application" {
  description = "application name"
}

variable "aws_region" {
  description = "aws region"
}

variable "stack_id" {
  description = "stack id e.g. blue|green, 01|02"
}

variable "kms_key" {
  description = "kms key id"
}

variable "fifo_topic" {
  description = "fifo topic [ true | false ]"
}
