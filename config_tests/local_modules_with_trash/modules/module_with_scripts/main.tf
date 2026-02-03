variable "prefix" {
  type        = string
  description = "Prefix for resource names"
}

resource "terraform_data" "script_runner" {
  input = {
    prefix = var.prefix
    timestamp = timestamp()
  }
}

resource "null_resource" "example" {
  triggers = {
    script_hash = filemd5("${path.module}/scripts/setup.sh")
  }
}

output "resource_id" {
  value = terraform_data.script_runner.id
}
