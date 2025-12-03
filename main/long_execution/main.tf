# Long-running Terraform configuration for testing Scalr agent grace shutdown
# This configuration creates multiple types of long-running operations

variable "sleep_duration" {
  description = "Duration in seconds for sleep operations"
  type        = number
  default     = 600  # 10 minutes - adjust based on your grace shutdown timeout
}

variable "resource_count" {
  description = "Number of resources to create for extended planning time"
  type        = number
  default     = 100
}

variable "enable_external_data" {
  description = "Enable external data source with long execution"
  type        = bool
  default     = true
}

# Method 1: Using local-exec provisioners with sleep
resource "terraform_data" "long_sleep" {
  count = var.resource_count
  
  triggers_replace = {
    timestamp = timestamp()
    index     = count.index
  }
  
  provisioner "local-exec" {
    command = "echo 'Starting long operation ${count.index}' && sleep ${var.sleep_duration / 10}"
  }
  
  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Destroying resource ${count.index}' && sleep 5"
  }
}

# Method 2: Using null_resource with trap-aware script
resource "null_resource" "trap_aware_sleep" {
  count = 5
  
  triggers = {
    timestamp = timestamp()
    index     = count.index
  }
  
  provisioner "local-exec" {
    command = <<-EOT
      #!/bin/bash
      
      # Trap SIGTERM for graceful handling
      cleanup() {
        echo "Received SIGTERM, cleaning up resource ${count.index}..."
        sleep 5
        echo "Cleanup complete for resource ${count.index}"
        exit 0
      }
      
      trap cleanup SIGTERM
      
      echo "Starting long operation for resource ${count.index}"
      for i in $(seq 1 ${var.sleep_duration}); do
        echo "Resource ${count.index}: Step $i/${var.sleep_duration}"
        sleep 1
      done
      echo "Completed long operation for resource ${count.index}"
    EOT
    
    interpreter = ["bash", "-c"]
  }
}

# Method 3: External data source with long execution
data "external" "long_running_script" {
  count = var.enable_external_data ? 1 : 0
  
  program = ["bash", "-c", <<-EOT
    #!/bin/bash
    
    # Function to handle SIGTERM gracefully
    cleanup() {
      echo '{"status": "interrupted", "duration": "'$SECONDS'"}' >&2
      echo '{"result": "interrupted"}'
      exit 0
    }
    
    trap cleanup SIGTERM
    
    echo "Starting external data processing..." >&2
    
    # Simulate long-running data processing
    for i in $(seq 1 ${var.sleep_duration}); do
      echo "Processing step $i/${var.sleep_duration}..." >&2
      sleep 1
    done
    
    echo '{"result": "completed", "duration": "'${var.sleep_duration}'"}'
  EOT
  ]
}

# Method 4: Time-based resource for additional delay
resource "time_sleep" "wait_before_completion" {
  depends_on = [
    terraform_data.long_sleep,
    null_resource.trap_aware_sleep
  ]
  
  create_duration = "${var.sleep_duration}s"
}

# Method 5: Large number of random resources for extended planning
resource "random_pet" "many_pets" {
  count = var.resource_count * 2
  
  keepers = {
    timestamp = timestamp()
    index     = count.index
  }
  
  length = 3
}

resource "random_password" "many_passwords" {
  count = var.resource_count
  
  length  = 32
  special = true
  
  keepers = {
    timestamp = timestamp()
    index     = count.index
  }
}

# Method 6: Complex string operations for CPU-intensive planning
locals {
  # Generate complex strings that require significant processing
  complex_strings = [
    for i in range(var.resource_count) : 
    join("-", [
      for j in range(10) : 
      substr(sha256("${timestamp()}-${i}-${j}"), 0, 8)
    ])
  ]
  
  # Nested loops for additional complexity
  nested_data = {
    for i in range(min(var.resource_count, 50)) : 
    "group_${i}" => {
      for j in range(20) : 
      "item_${j}" => {
        value = base64encode("${timestamp()}-${i}-${j}")
        hash  = sha256("${i}-${j}")
      }
    }
  }
}

# Output the complex data (forces evaluation during plan)
output "complex_strings_sample" {
  value = slice(local.complex_strings, 0, min(5, length(local.complex_strings)))
}

output "nested_data_keys" {
  value = keys(local.nested_data)
}

output "execution_info" {
  value = {
    sleep_duration  = var.sleep_duration
    resource_count  = var.resource_count
    start_time     = timestamp()
    external_data  = var.enable_external_data ? data.external.long_running_script[0].result : null
  }
}

# Method 7: File operations that can be interrupted
resource "local_file" "large_files" {
  count = 10
  
  filename = "/tmp/scalr_test_${count.index}.txt"
  content = join("\n", [
    for i in range(1000) : 
    "Line ${i} - ${timestamp()} - Resource ${count.index}"
  ])
  
  provisioner "local-exec" {
    command = "echo 'Created file ${self.filename}' && sleep 10"
  }
  
  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Removing file ${self.filename}' && rm -f ${self.filename}"
  }
}