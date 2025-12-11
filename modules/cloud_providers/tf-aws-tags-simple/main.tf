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
    tags = merge(local.other_tags, {})
  }
}

variable "dummy" {
  type = string
  default = "test"
}

locals {
  armor = "1"
  burst = "2"
}
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

locals {
  other_tags = {
    some_b = var.dummy
  }
  some_value = "some_value"
}

resource "aws_s3_bucket" "simple_bucket" {
  bucket = "scalr-simple-tags-${random_id.bucket_suffix.hex}"
}