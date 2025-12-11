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

locals {
  common_tags = {
    a = "1"
    b = "2"
  }
}

locals {
  other_tags = {
    first   = "first"
    email       = "some.PLACEHOLDER@example.com"
    slashes     = "some/value/with/slashes"
  }
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "simple_bucket" {
  bucket = "scalr-simple-tags-${random_id.bucket_suffix.hex}"
}