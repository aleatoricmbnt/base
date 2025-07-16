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

variable "create_account_shell_variable" {
  description = "Whether to create account-level shell variable (1 = create, 0 = skip)"
  type        = number
  default     = 1
}

variable "create_environment_shell_variable" {
  description = "Whether to create environment-level shell variable (1 = create, 0 = skip)"
  type        = number
  default     = 1
}

variable "create_workspace_shell_variable" {
  description = "Whether to create workspace-level shell variable (1 = create, 0 = skip)"
  type        = number
  default     = 1
}

variable "create_workspace_terraform_variable" {
  description = "Whether to create workspace-level terraform variable (1 = create, 0 = skip)"
  type        = number
  default     = 1
}

variable "var_files" {
  description = <<EOT
  List of var files to be used in the workspace. I.e. ["test_source/var-precedence/test.tfvars"]
  EOT
  type        = list(string)
  default     = null
}