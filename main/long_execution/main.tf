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
  default     = "https://releases.ubuntu.com/22.04/ubuntu-22.04.3-desktop-amd64.iso"  # ~4GB file
}

variable "enable_slow_download" {
  description = "Enable slow download test"
  type        = bool
  default     = true
}

# Data source 1: Slow network download with throttling
data "external" "slow_download" {
  count = var.enable_slow_download ? 1 : 0
  
  program = ["bash", "-c", <<-EOT
    echo "Starting slow download..." >&2
    # Use curl with speed limit (10KB/s) and timeout, ignore signals initially
    trap '' TERM INT
    timeout ${var.sleep_duration} curl -L --limit-rate 10k --max-time ${var.sleep_duration} "${var.download_url}" -o /tmp/test_download_$$.tmp >&2 2>/dev/null || true
    rm -f /tmp/test_download_$$.tmp 2>/dev/null || true
    echo '{"result": "download_attempted", "duration": "${var.sleep_duration}"}'
  EOT
  ]
}

# Data source 2: Multiple DNS lookups with delays
data "external" "slow_dns_lookups" {
  program = ["bash", "-c", <<-EOT
    echo "Starting DNS lookups..." >&2
    trap '' TERM INT
    for host in google.com github.com stackoverflow.com reddit.com wikipedia.org; do
      echo "Looking up $host..." >&2
      nslookup $host >&2 2>/dev/null || true
      sleep 10
    done
    echo '{"result": "dns_lookups_completed"}'
  EOT
  ]
}

# Data source 3: Simple long sleep with signal trapping
data "external" "uninterruptible_sleep" {
  program = ["bash", "-c", <<-EOT
    echo "Starting uninterruptible sleep..." >&2
    trap 'echo "Ignoring signal..." >&2' TERM INT HUP
    sleep ${var.sleep_duration}
    echo '{"result": "sleep_completed"}'
  EOT
  ]
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
  value = var.enable_slow_download ? data.external.slow_download[0].result : "disabled"
}

output "dns_result" {
  value = data.external.slow_dns_lookups.result
}

output "sleep_result" {
  value = data.external.uninterruptible_sleep.result
}

output "execution_info" {
  value = {
    sleep_duration = var.sleep_duration
    download_url   = var.download_url
    start_time     = timestamp()
  }
}