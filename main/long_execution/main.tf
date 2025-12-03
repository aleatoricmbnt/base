# Simplified long-running Terraform configuration for testing Scalr agent grace shutdown
# Focus on plan phase with network operations and data sources

variable "sleep_duration" {
  description = "Duration in seconds for sleep operations"
  type        = number
  default     = 300  # 5 minutes
}

variable "download_url" {
  description = "URL to download during plan phase (use large file for slow download)"
  type        = string
  default     = "https://httpbin.org/delay/180"  # Simple 3-minute delay endpoint
}

variable "enable_slow_download" {
  description = "Enable slow download test"
  type        = bool
  default     = true
}

# Data source 1: Simple long-running sleep (most reliable)
data "external" "long_sleep" {
  count = var.enable_slow_download ? 1 : 0
  
  program = ["sh", "-c", "echo 'Starting ${var.sleep_duration} second sleep...' >&2; sleep ${var.sleep_duration}; echo '{\"result\": \"sleep_completed\", \"duration\": \"${var.sleep_duration}\"}'"]
}

# Single resource with timestamp trigger (forces plan on every run)
resource "terraform_data" "timestamp_trigger" {
  triggers_replace = {
    timestamp = timestamp()
  }
  
  provisioner "local-exec" {
    command = "echo 'Resource created at: ${timestamp()}' && sleep 30"
  }
}

# Outputs to force data source evaluation during plan
output "download_result" {
  value = var.enable_slow_download ? data.external.long_sleep[0].result : { result = "disabled" }
}

output "execution_info" {
  value = {
    sleep_duration = var.sleep_duration
    download_url   = var.download_url
    start_time     = timestamp()
  }
}