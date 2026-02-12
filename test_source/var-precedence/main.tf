terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

variable "test_var" {
  description = "Test variable for precedence testing"
  type        = string
  default     = "default-value"
}

# Simple test resource to show variable value
resource "null_resource" "precedence_test" {
  triggers = {
    test_value = var.test_var
    timestamp  = timestamp()
  }

  provisioner "local-exec" {
    command = <<-EOT
      echo "=== Variable Precedence Test ==="
      echo "Resolved value: ${var.test_var}"
      echo "Expected precedence order:"
      echo "1. var-file (test.tfvars)"
      echo "2. workspace terraform"
      echo "3. *.auto.tfvars"
      echo "4. terraform.tfvars.json"
      echo "5. workspace shell"
      echo "6. environment shell"
      echo "7. account shell"
    EOT
  }
}

output "test_result" {
  description = "Result of the variable precedence test"
  value       = var.test_var

} 

#some PR
