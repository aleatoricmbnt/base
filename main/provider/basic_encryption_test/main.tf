terraform {
  required_providers {
    scalr = {
      source = "registry.scalr.io/scalr/scalr"
    }
  }
}

data "scalr_current_run" "this" {}

resource "scalr_workspace" "test_creation_or_update" {
  name              = var.workspace_name
  environment_id    = data.scalr_current_run.this.environment_id
  working_directory = "example/path"
}

variable "workspace_name" {
  type        = string
  description = "Set the name of the workspace"
}

resource "terraform_data" "run_var_input" {
  input = var.sensitive_run_var
}

variable "sensitive_run_var" {
  type        = string
  sensitive   = true
  description = "Set any value as a run variable"
}

resource "terraform_data" "ui_var_input" {
  input = var.sensitive_ui_var
}

variable "sensitive_ui_var" {
  type        = string
  sensitive   = true
  description = "Set any value as a UI variable"
}

output "run_var" {
  value     = terraform_data.run_var_input.output
  sensitive = true
}

output "ui_var" {
  value     = terraform_data.ui_var.output
  sensitive = true
}

output "workspace_id" {
  value = scalr_workspace.example.id
}