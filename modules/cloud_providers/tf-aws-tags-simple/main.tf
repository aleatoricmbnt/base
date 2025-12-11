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
    tags = local.other_tags
  }
}

variable "dummy" {
  type = string
  default = "test"
}

locals {
  a = "1"
  b = "2"
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

locals {
  other_tags = {
    b = var.dummy
  }
  some_value = "some_value"
}

resource "aws_s3_bucket" "simple_bucket" {
  bucket = "scalr-simple-tags-${random_id.bucket_suffix.hex}"
}