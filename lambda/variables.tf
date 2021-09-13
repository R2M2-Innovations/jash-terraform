variable "account" {
  description = "aws account id"
}

variable "region" {
  description = "aws region e.g. us-east-1, us-west-2"
}

variable "organization" {
  description = "organization name e.g. com, sky"
}

variable "application" {
  description = "application name"
}

variable "environment" {
  description = "environment e.g. dev, qa, prod"
}

variable "stack_id" {
  description = "environment e.g. blue|green, 1|2, a|b"
}

variable "deployment_type" {
  description = "deployment_type"
}

variable "deployment_repo" {
  description = "deployment repo"
}

variable "source_type" {
  description = "source deployment type e.g. file|s3"
}

variable "source_file" {
  description = "source deployment zip file if source_type = file"
}

variable "source_s3_bucket" {
  description = "source deployment bucket if source_type = s3"
}

variable "source_s3_key" {
  description = "source deployment key if source_type = s3"
}

variable "source_s3_object_version" {
  description = "source deployment object version if source_type = s3"
}

variable "handler" {
  description = "lambda function handler entry point"
}

variable "runtime" {
  description = "lambda function runtime"
}

variable "memory_size" {
  description = "memory allocated to function in MB"
}

variable "timeout" {
  description = "function timeout in seconds"
}

variable "concurrency" {
  description = "reserved concurrent executions 0 = disable, -1 unlimited"
}

variable "env_vars" {
  type = map 
  description = "environment variables to pass to function"
}

variable "vpc_subnet_ids" {
  type = list(string)
  description = "optional vpc subnet ids to deploy in"
}

variable "vpc_security_groups" {
  type = list(string)
  description = "optional vpc security associated w/ vpc subnet deployments"
}

variable "publish" {
  description = "deploy as a new version [ true | false ]"
}

variable "trace" {
  description = "enable/disable x-ray tracing [ true | false ]"
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
  }
}

