terraform {
  required_version = ">= 1.4.0"
}

# 1. Default value in code, sensitive
variable "from_default_sensitive" {
  type        = string
  sensitive   = true
  description = "Sensitive string with a default in Terraform (legacy-style secret in config)."
  default     = "default-secret-plain"
}

# 2. No default: set in Scalr UI as a sensitive Terraform variable
variable "from_ui_sensitive" {
  type        = string
  sensitive   = true
  description = "Sensitive, no default — define in Scalr UI (mark as sensitive)."
}

# 3. No default: set via shell, e.g. TF_VAR_from_shell_env=hello (not sensitive)
variable "from_shell_env" {
  type        = string
  sensitive   = false
  description = "Non-sensitive, no default — pass with -var or TF_VAR_from_shell_env in the run environment."
}

# 4. No default: set in Scalr UI, not sensitive
variable "from_ui_plain" {
  type        = string
  sensitive   = false
  description = "Non-sensitive, no default — define in Scalr UI."
}

# 5. Default sensitive multiline (heredoc)
variable "from_default_sensitive_heredoc" {
  type        = string
  sensitive   = true
  description = "Sensitive multiline default (heredoc) for sanitizer edge cases."
  default     = <<-EOT
    line-one-secret
    line-two-secret
  EOT
}

# 6. Default sensitive complex value (object with multiline string)
variable "from_default_sensitive_complex" {
  type = object({
    id      = string
    payload = string
  })
  sensitive   = true
  description = "Sensitive object default including a multiline string field."
  default = {
    id      = "obj-default-id"
    payload = <<-EOT
      multiline
      object
      payload
    EOT
  }
}

resource "terraform_data" "policy_sanitize_inputs" {
  input = {
    from_default_sensitive         = var.from_default_sensitive
    from_ui_sensitive              = var.from_ui_sensitive
    from_shell_env                 = var.from_shell_env
    from_ui_plain                  = var.from_ui_plain
    from_default_sensitive_heredoc = var.from_default_sensitive_heredoc
    from_default_sensitive_complex = var.from_default_sensitive_complex
  }
}

output "all_vars_yaml" {
  description = "All fixture variables as one YAML string (sensitive because it includes sensitive inputs)."
  sensitive   = true
  value = yamlencode({
    from_default_sensitive         = var.from_default_sensitive
    from_ui_sensitive              = var.from_ui_sensitive
    from_shell_env                 = var.from_shell_env
    from_ui_plain                  = var.from_ui_plain
    from_default_sensitive_heredoc = var.from_default_sensitive_heredoc
    from_default_sensitive_complex = var.from_default_sensitive_complex
  })
}
