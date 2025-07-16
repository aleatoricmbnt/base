variable "test_workspace_name" {
  description = "Name of the test workspace to create"
  type        = string
  default     = "var-precedence-test"
}

variable "vcs_provider_id" {
  description = "VCS provider ID for the workspace"
  type        = string
  default     = null
}

variable "var_files" {
  description = <<EOT
  List of var files to be used in the workspace. I.e. ["test_source/var-precedence/test.tfvars"]
  EOT
  type        = list(string)
  default     = null
}