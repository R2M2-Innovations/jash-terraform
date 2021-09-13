variable "account" {
  description = "aws account"
}

variable "region" {
  description = "aws region e.g. us-east-1, us-west-2"
}

variable "organization" {
  description = "organization name"
}

variable "application" {
  description = "application name"
}

variable "environment" {
  description = "environment e.g. dev, qa, prod"
}

variable "stack_id" {
  description = "stack id e.g. blue|green, 01|02"
}

variable "deployment_type" {
  description = "deployment type e.g. console|cloudformation|terraform"
}

variable "deployment_repo" {
  description = "deployment repo"
}

variable "compliance" {
  description = "compliance e.g. pci|sox"
}

variable "deployment_version" {
  description = "deployment version"
}

variable "type" {
  description = "type = 'EDGE|REGIONAL|PRIVATE'"
}

variable "custom_domains" {
  description = "use custom domain(s) [true | false]"
}

variable "stages" {
  description = "deployment stages"
}

variable "stage_variables" {
  type = map 
  description = "stage definitions"
}

variable "access_logs" {
  description = "enable access logs"
}

locals {
  common_tags = {
    Name            = "${var.organization}-${var.application}-${var.environment}-${var.stack_id}"
    organization    = var.organization
    application     = var.application
    environment     = var.environment
    stack_id        = var.stack_id
    deployment_type = var.deployment_type
    deployment_repo = var.deployment_repo
    compliance      = var.compliance
  }
}
