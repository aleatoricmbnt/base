terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  
  default_tags {
    tags = local.common_tags
  }
}

# Simple locals with tag map
locals {
  common_tags = {
    Environment = "development"
    ManagedBy   = "terraform"
    CostCenter  = "qa-team"
  }
}

variable "default_tags" {
  default     = {
     Owner       = "TFProviders"
     Project     = "Test"
}
  description = "Default Tags for smth"
  type        = map(string)
}

resource "aws_s3_bucket" "simple_bucket" {
  bucket = "scalr-simple-tags-${random_id.bucket_suffix.hex}"
  tags = merge(
    var.default_tags,
    {
     Name = "myBucket"
    }
  )
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}


output "simple_bucket_tags" {
  description = "Tags applied to simple bucket"
  value       = aws_s3_bucket.simple_bucket.tags
}

output "expected_merge_behavior" {
  description = "Documentation of expected behavior based on strategy"
  value = <<-EOT
    SKIP strategy: User-defined tags from locals take precedence over provider default tags
    UPDATE strategy: Provider default tags override user-defined tags from locals
    
    Test this configuration with both strategies to validate HCL parser handles locals correctly.
  EOT
}
