output "account" {
  value = var.account
}

output "region" {
  value = var.region
}

output "organization" {
  value = var.organization
}

output "application" {
  value = var.application
}

output "environment" {
  value = var.environment
}

output "stack_id" {
  value = var.stack_id
}

output "deployment_type" {
  value = var.deployment_type
}

output "deployment_repo" {
  value = var.deployment_repo
}

output "compliance" {
  value = var.compliance
}

output "deployment_version" {
  value = var.deployment_version
}

output "type" {
  value = var.type
}

output "custom_domains" {
  value = var.custom_domains
}

output "stages" {
  value = var.stages
}

output "stage_variables" {
  value = var.stage_variables
}

output "access_logs" {
  value = var.access_logs
}

output "rest_api_ids" {
  value = join(",",aws_api_gateway_rest_api.api_gateway_rest_api.*.id)
}
