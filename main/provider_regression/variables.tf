variable "github_vcs_token" {
  sensitive   = true
  description = "Token used to create VCS. Only Github token is accepted due to hardcoded VCS type."
}

variable "opa_version" {
  description = "OPA version used to create policy group. Should be one of available with current instance."
  default     = "0.29.4"
}

variable "pg_vcs-repo_identifier" {
  description = "'vcs_repo.indentifier' used to create policy group."
  default     = "aleatoricmbnt/tf-revizor-fixtures"
}

variable "pg_vcs-repo_path" {
  description = "'vcs_repo.path' used to create policy group. If your policy is located in the root folder, submit blank string (will default to repo root)."
  default     = "policies/random_decision"
}

variable "pg_vcs-repo_branch" {
  description = "'vcs_repo.branch' used to create policy group."
  default     = "master"
}

variable "ep_url" {
  description = "Endpoint URL used to create Scalr endpoint."
  default     = "https://webhook.site/617a25c8-5265-4198-8032-bc3ceb150173"
}

variable "mod_vcs-repo_identifier" {
  description = "'vcs_repo.indentifier' used to create a module."
  default     = "aleatoricmbnt/tf-revizor-fixtures"
}

variable "mod_vcs-repo_path" {
  description = "'vcs_repo.path' used to create a module. If your module is located in the root folder, submitting blank string MIGHT work."
  default     = "modules/terraform-null-module"
}

variable "mod_vcs-repo_tag-prefix" {
  description = "'vcs_repo.tag-prefix' used to create a module."
  default     = "null/"
}

variable "pcfg_gcp_credentials" {
  description = "Google service account key file in JSON format."
  sensitive   = true
}

variable "ws-vcs_vcs-repo_identifier" {
  description = "'vcs_repo.indentifier' used to create policy group."
  default     = "aleatoricmbnt/tf-revizor-fixtures"
}

variable "ws-vcs_vcs-repo_branch" {
  description = "'vcs_repo.branch' used to create policy group."
  default     = "master"
}

variable "ws-vcs_workdir" {
  description = "Working directory (path) used to create workspace. Submit blank if configuration is located in the repository root."
  default     = "local_wait"
}

variable "my_ip" {
  description = "IP which will be added to the whitelist during run. Ensure to add your IP, otherwise you'll be banned."
}

variable "user_email" {
  description = "Email used for user data source"
  default     = "aleatoricmbnt@gmail.com"
}

variable "modver_source" {
  description = "Source of the module used for data source. Format: env-xxxxxx/resource-name/scalr"
  default     = "env-uae22nj71qe9dh8/module/null"
}

variable "modver_version" {
  description = "Version of the module used for data source"
  default     = "0.0.1"
}