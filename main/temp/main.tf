# locals {
#   config  = yamldecode(file("${path.module}/${var.environment}.yaml"))
#   regions = local.config.regions
# }

# provider "aws" {
#   for_each = local.regions
#   region   = each.key
#   alias    = "by_region"
# }

# resource "aws_s3_bucket" "alfiias_bucket" {
#   for_each = local.regions
#   provider = aws.regions[each.key]
#   bucket = "alfiia-test-s3-${var.environment}-${each.key}" # 
#   tags = {
#     Environment = var.environment
#     Region      = each.key
#   }
# }

resource "terraform_data" "this" {
  triggers_replace = timestamp()
}