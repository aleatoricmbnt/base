# Variables for Scalr Provider Testing
# This file supports the main.tf configuration for testing account_id deprecation

variable "scalr_hostname" {
  description = "The Scalr hostname (e.g., account.scalr.io)"
  type        = string
  default     = null
}

variable "scalr_token" {
  description = "The Scalr API token for authentication"
  type        = string
  sensitive   = true
  default     = null
}

variable "test_user_email" {
  description = "Email address for testing IAM user data source"
  type        = string
  default     = "test@example.com"
}

variable "aws_access_key" {
  description = "AWS access key for provider configuration testing"
  type        = string
  sensitive   = true
  default     = "dummy-access-key-for-testing"
}

variable "aws_secret_key" {
  description = "AWS secret key for provider configuration testing"
  type        = string
  sensitive   = true
  default     = "dummy-secret-key-for-testing"
}

variable "test_ssh_public_key" {
  description = "SSH public key for testing SSH key resource"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7Xu8h2hFKWd6EkOl0Xk9VhKM4zYFBZg1p2Nz4V5n6N7h8K9L0 test@example.com"
}

variable "vcs_token" {
  description = "VCS provider token for testing"
  type        = string
  sensitive   = true
  default     = "dummy-vcs-token-for-testing"
}

variable "test_repository" {
  description = "Test repository identifier for VCS configuration"
  type        = string
  default     = "test-org/test-repo"
}

variable "terraform_state_bucket" {
  description = "S3 bucket name for storage profile testing"
  type        = string
  default     = "test-terraform-state-bucket-12345"
}

variable "webhook_url" {
  description = "Webhook URL for testing webhook resource"
  type        = string
  default     = "https://webhook.example.com/scalr"
}

variable "endpoint_url" {
  description = "Endpoint URL for testing endpoint resource"
  type        = string
  default     = "https://api.example.com/test"
}

variable "aws_role_arn" {
  description = "AWS IAM role ARN for workload identity provider testing"
  type        = string
  default     = "arn:aws:iam::123456789012:role/ScalrTestRole"
}
