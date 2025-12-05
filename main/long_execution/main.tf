variable "enable_slow_run" {
  description = "Enable slow download test"
  type        = bool
  default     = true
}

variable "sleep_duration" {
  description = "Duration in seconds for sleep operations"
  type        = number
  default     = 180  # 3 minutes
}

data "external" "long_sleep" {
  count = var.enable_slow_run ? 1 : 0
  
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
  value = var.enable_slow_run ? data.external.long_sleep[0].result : { result = "disabled" }
}

output "execution_info" {
  value = {
    sleep_duration = var.sleep_duration
    start_time     = timestamp()
  }
}
