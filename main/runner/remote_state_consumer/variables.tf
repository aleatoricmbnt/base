variable "remote_state_hostname" {
  type        = string
  description = "Terraform Cloud / Enterprise hostname for the remote state backend."
  default     = "test.mshytse-tests.testenv.scalr.dev"
}

variable "remote_state_organization" {
  type        = string
  description = "Organization (environment) name on the remote backend."
  default     = "env-v0p5qmic8hdkh0m1p"
}

variable "remote_state_workspace_name" {
  type        = string
  description = "Workspace name whose state is read (should be the tf-var-types workspace)."
  default     = "tf-var-types"
}
