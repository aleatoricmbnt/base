# Variables with no defaults - must be provided via Scalr UI
variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, staging, prod)"
}

variable "instance_count" {
  type        = number
  description = "Number of instances to create"
}

variable "enable_monitoring" {
  type        = bool
  description = "Enable monitoring for resources"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
}

# Simple null resource to demonstrate the variables are being used
resource "null_resource" "test" {
  triggers = {
    environment       = var.environment
    instance_count    = var.instance_count
    enable_monitoring = var.enable_monitoring
    tags              = jsonencode(var.tags)
  }
}

# Outputs to verify the values
output "environment" {
  value       = var.environment
  description = "The environment name provided"
}

output "instance_count" {
  value       = var.instance_count
  description = "The instance count provided"
}

output "enable_monitoring" {
  value       = var.enable_monitoring
  description = "Whether monitoring is enabled"
}

output "tags" {
  value       = var.tags
  description = "The tags provided"
}

