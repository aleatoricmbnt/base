output "simple_string" {
  value       = "Hello, Terraform"
  description = "A basic string output."
}

output "short_number" {
  value = 42
}

output "boolean_flag" {
  value       = true
  description = "Indicates if the feature flag is enabled."
}

output "list_of_strings" {
  value       = ["alpha", "beta", "gamma"]
  description = "List of environment names."
}

output "map_of_ports" {
  value = {
    http  = 80
    https = 443
  }
}

output "object_example" {
  value = {
    id   = "abc-123"
    name = "example"
    tags = ["dev", "infra"]
  }
  description = "An example object output with multiple fields."
}

output "tuple_example" {
  value = ["web", 2, true]
  description = "A tuple of mixed types."
}

output "null_example" {
  value       = null
  description = "Explicitly null output."
}

output "public_ip" {
  value = var.public_ip

  precondition {
    condition     = var.public_ip != ""
    error_message = "It does not have a public IP address."
  }
}

variable "public_ip" {
  default = "255.255.255.255"
}

output "long_text_block" {
  value = <<EOT
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor,
dignissim sit amet, adipiscing nec, ultricies sed, dolor. Cras elementum ultrices diam.
EOT
}

output "region" {
  value       = var.aws_region
  description = "AWS region used for deployment."
}

variable "aws_region" {
  default = "us-east1"
}

output "availability_zones" {
  value = ["us-west-1a", "us-west-1b", "us-west-1c"]
}

output "instance_ids" {
  value = toset(["i-1234567890abcdef0", "i-0abcdef1234567890"])
}

output "map_of_users" {
  value = {
    alice = "admin"
    bob   = "developer"
    eve   = "readonly"
  }
}

output "complex_nested_object" {
  value = {
    app = {
      name    = "terraform-demo"
      version = "1.0.0"
    }
    resources = {
      instances = 3
      db        = "postgres"
    }
  }
}

output "sensitive_token" {
  value     = "s3cr3t-t0ken"
  sensitive = true
}

output "json_encoded_output" {
  value       = jsonencode({ env = "prod", scale = 5 })
  description = "JSON encoded string of deployment metadata."
}

output "length_of_list" {
  value = length(["a", "b", "c"])
}

output "calculated_value" {
  value = 5 * 3 + 7
}

output "nested_map_list" {
  value = {
    service_a = ["1.1.1", "1.1.2"]
    service_b = ["2.0.0"]
  }
}

output "optional_output" {
  value       = try(var.optional_value, "default-value")
  description = "Fallback to default if optional_value is not set."
}

variable "optional_value" {
  default = null
}