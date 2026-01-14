variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}

variable "trigger_value" {
  description = "Value that triggers resource recreation"
  type        = string
  default     = "initial"
}

# Simple terraform_data resource that generates a timestamp
resource "terraform_data" "timestamp" {
  input = timestamp()
}

# terraform_data resource that uses variables and triggers on changes
resource "terraform_data" "config" {
  input = {
    environment = var.environment
    tags        = var.tags
    trigger     = var.trigger_value
  }

  triggers_replace = [
    var.trigger_value
  ]
}

# terraform_data with provisioner-like behavior
resource "terraform_data" "computed_value" {
  input = {
    environment = var.environment
    computed_id = "${var.environment}-${substr(md5(var.trigger_value), 0, 8)}"
  }
}

output "timestamp" {
  description = "Generated timestamp"
  value       = terraform_data.timestamp.output
}

output "config" {
  description = "Configuration data"
  value       = terraform_data.config.output
}

output "computed_id" {
  description = "Computed identifier"
  value       = terraform_data.computed_value.output.computed_id
}

output "environment" {
  description = "Environment name"
  value       = var.environment
}
