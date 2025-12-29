# Required variables with NO defaults - must be provided via Scalr UI
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

variable "config" {
  type = object({
    name        = string
    enabled     = bool
    max_retries = number
  })
  description = "Configuration object"
}

# Resource that uses all required variables
resource "terraform_data" "required_vars_test" {
  input = {
    environment       = var.environment
    instance_count    = var.instance_count
    enable_monitoring = var.enable_monitoring
    tags              = var.tags
    config            = var.config
  }
  
  triggers_replace = {
    environment = var.environment
    config_name = var.config.name
  }
}

# Outputs that should clearly show if variables are populated
output "all_variables" {
  value = {
    environment       = var.environment
    instance_count    = var.instance_count
    enable_monitoring = var.enable_monitoring
    tags              = var.tags
    config            = var.config
  }
  description = "All required variables - check if these are populated in agent run"
}

output "environment" {
  value       = var.environment
  description = "Environment variable value"
}

output "instance_count" {
  value       = var.instance_count
  description = "Instance count variable value"
}

output "enable_monitoring" {
  value       = var.enable_monitoring
  description = "Enable monitoring variable value"
}

output "tags" {
  value       = var.tags
  description = "Tags variable value"
}

output "config" {
  value       = var.config
  description = "Config object variable value"
}

