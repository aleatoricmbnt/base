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
    tags = merge(local.common_tags, local.other_tags)
  }
}

variable "default_tags2" {
  type = map(string)
  default = {
    ManagedBy = "OpenTofu"
  }
}

locals {
  a = "1"
}
locals {
  b = "2"
}

locals {
  # Merging with variable and inline map
  common_tags = merge(
    var.default_tags2,
    {
      for k, v in {
        Environment = "dev"
        Region      = "us-east-1"
      } : k => lower(v)
    }
  )
}

locals {
  other_tags = {
    ManagedBy   = "terraform"
    custom      = var.custom_tag
    email       = "some.PLACEHOLDER@example.com"
    slashes     = "some/value/with/slashes"
    custom_ins  = "custom_inserted_here_${var.custom_tag}"
  }
  some_value = "some_value"
}

variable "custom_tag" {
  type = string
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "simple_bucket" {
  bucket = "scalr-simple-tags-${random_id.bucket_suffix.hex}"
  tags   = local.other_tags
}

# Just locals and misc

variable "default_tags" {
  default     = {
     Owner       = "TFProviders"
     Project     = "Test"
}
  description = "Default Tags for smth"
  type        = map(string)
}

locals {
  tag_keys = ["Environment", "Team", "CostCenter"]
  tag_values = ["dev", "platform", "engineering"]
  
  # For expression to create map
  some_common_tags = {
    for idx, key in local.tag_keys : key => local.tag_values[idx]
  }
}

locals {}

locals {
  numeric_value = 10
  numberic_value_in_string = "10"
}

# Second provider block - this could cause merge conflicts
# provider "aws" {
#   alias  = "secondary"
#   region = "us-west-2"
  
#   default_tags {
#      tags = local.other_tags
#   }
# }

# resource "aws_s3_bucket" "secondary_bucket" {
#   provider = aws.secondary
#   bucket = "scalr-secondary-${random_id.bucket_suffix.hex}"
#   tags = merge(
#     var.default_tags,
#     {
#      Name = "myBucket"
#     }
#   )
# }