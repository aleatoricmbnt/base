terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.70.0"
    }
  }
}

resource "aws_iam_policy" "safe_policy" {
  name        = "safe-policy"
  description = "A policy that passes all Checkov checks"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = ["s3:GetObject"]
      Resource  = ["arn:aws:s3:::example-bucket/specific-path/*"]
      Condition = {
        IpAddress = {"aws:SourceIp" = ["192.0.2.0/24"]}
      }
    }]
  })
}