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
    iacplatform = "OpenTofu"
  }
}

# locals {
#   a = "1"
# }

# locals {
#   b = "2"
# }

locals {
  common_tags = merge(
    var.default_tags2,
    {
      Environment = "dev"
    }
  )
}

locals {
  other_tags = {
    ManagedBy = "terraform"
  }
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "simple_bucket" {
  bucket = "scalr-simple-tags-${random_id.bucket_suffix.hex}"
}