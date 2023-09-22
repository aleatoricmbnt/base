terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.22"
    }
  }
}

# -------------------------------------------------------------------------------------------
# ----------------------------------- CONFIGURE PROVIDERS -----------------------------------
# -------------------------------------------------------------------------------------------

provider "aws" {
  region = "us-east-1"
}

# -------------------------------------------------------------------------------------------
# ------------------------------------------- AWS -------------------------------------------
# -------------------------------------------------------------------------------------------


resource "aws_s3_bucket" "b" {
  count  = var.quantity
  bucket = var.bucket_name
  tags   = var.tags
}

variable "bucket_name" {
  default = "bucketaleatoric"
  type    = string
}

variable "tags" {
  type = map(any)
  default = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

variable "quantity" {
  type        = number
  description = "Number of buckets to be created"
}