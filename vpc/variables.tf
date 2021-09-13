variable "region" {
  description = "aws region e.g. us-east-1, us-west-2"
}

variable "organization" {
  description = "organization name"
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

variable "vpc_cidr_block" {
  description = "vpc cidr block"
}

variable "enable_dns_support" {
  description = "enable vpc dns support"
}

variable "enable_dns_hostnames" {
  description = "enable vpc dns hostnames"
}

variable "public_subnets" {
  type = list(string)
  description = "public subnets"
}

variable "deploy_nat_gateways" {
  description = "deploy nat gateways"
}

variable "private_subnets" {
  type = list(string)
  description = "private subnets"
}

locals {
  common_tags = {
    organization = var.organization
    environment = var.environment
    stack_id = var.stack_id
    deployment_type = var.deployment_type
    deployment_repo = var.deployment_repo
    compliance      = var.compliance
  }
}
