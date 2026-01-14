terraform {
  required_providers {
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9"
    }
  }
}

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

variable "sleep_duration" {
  description = "Duration to sleep (e.g., '10s', '5m', '1h')"
  type        = string
  default     = "1s"
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

# Time sleep resource for testing long-running operations
resource "time_sleep" "wait" {
  create_duration = var.sleep_duration

  depends_on = [
    terraform_data.timestamp,
    terraform_data.config,
    terraform_data.computed_value
  ]
}

# Resource that depends on the sleep to simulate long-running workflows
resource "terraform_data" "after_sleep" {
  input = {
    completed_at = timestamp()
    waited_for   = var.sleep_duration
  }

  depends_on = [time_sleep.wait]
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

output "completion_info" {
  description = "Information about completion after sleep"
  value       = terraform_data.after_sleep.output
}
