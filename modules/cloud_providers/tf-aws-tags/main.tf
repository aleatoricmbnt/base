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

# Second provider block - this could cause merge conflicts
provider "aws" {
  alias  = "secondary"
  region = "us-west-2"
  
  default_tags {
     tags = local.other_tags
  }
}

locals {
  other_tags = {
    Environment = "development"
    ManagedBy   = "terraform"
    CostCenter  = "qa-team"
    custom      = var.custom_tag
    email       = "some.PLACEHOLDER@example.com"
    slashes     = "some/value/with/slashes"
  }
  some_value = "some_value"
}

variable "custom_tag" {
  type = string
}

locals {
  common_tags = {
    Environment = "development"
  }
}

locals {}

variable "default_tags" {
  default     = {
     Owner       = "TFProviders"
     Project     = "Test"
}
  description = "Default Tags for smth"
  type        = map(string)
}

# Should be: Environment
resource "aws_s3_bucket" "simple_bucket" {
  bucket = "scalr-simple-tags-${random_id.bucket_suffix.hex}"
}


# Should be: Owner, Project, Name, Environment, ManagedBy, CostCenter
resource "aws_s3_bucket" "secondary_bucket" {
  provider = aws.secondary
  bucket = "scalr-secondary-${random_id.bucket_suffix.hex}"
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
