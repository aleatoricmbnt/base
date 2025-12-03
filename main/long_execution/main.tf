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

# Data source 1: Slow network download with throttling
data "external" "slow_download" {
  count = var.enable_slow_download ? 1 : 0
  
  program = ["sh", "-c", "echo 'Starting slow download...' >&2; echo 'URL: ${var.download_url}' >&2; echo 'Testing curl availability...' >&2; which curl >&2 || echo 'curl not found' >&2; echo 'Starting download with verbose output...' >&2; curl -v -L --limit-rate 10k --max-time ${var.sleep_duration} '${var.download_url}' -o /tmp/test_download.tmp 2>&1 | head -20 >&2; echo 'Download command completed' >&2; rm -f /tmp/test_download.tmp 2>/dev/null; echo '{\"result\": \"download_attempted\", \"duration\": \"${var.sleep_duration}\"}'"]
}

# Data source 2: Multiple DNS lookups with delays
# data "external" "slow_dns_lookups" {
#   program = ["sh", "-c", "echo 'Starting DNS lookups...' >&2; nslookup google.com >&2; sleep 30; nslookup github.com >&2; sleep 30; nslookup stackoverflow.com >&2; sleep 30; echo '{\"result\": \"dns_lookups_completed\"}'"]
# }

# # Data source 3: Simple long sleep with signal trapping
# data "external" "uninterruptible_sleep" {
#   program = ["sh", "-c", "echo 'Starting uninterruptible sleep...' >&2; sleep ${var.sleep_duration}; echo '{\"result\": \"sleep_completed\"}'"]
# }

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
  value = var.enable_slow_download ? data.external.slow_download[0].result : { result = "disabled" }
}

# output "dns_result" {
#   value = data.external.slow_dns_lookups.result
# }

# output "sleep_result" {
#   value = data.external.uninterruptible_sleep.result
# }

output "execution_info" {
  value = {
    sleep_duration = var.sleep_duration
    download_url   = var.download_url
    start_time     = timestamp()
  }
}