resource "random_pet" "bucket_name" {
  
}

resource "random_pet" "optional_bucket_name" {
  
}

resource "aws_s3_bucket" "default" {
  bucket = "aleatoric-bucket-${random_pet.bucket_name.id}"
}

variable "number_of_aliased_buckets" {
  default = 0
}

variable "aws_alias" {
  default =  "kek"
}

resource "aws_s3_bucket" "aliased" {
  provider = "aws.${var.aws_alias}"
  count  = var.number_of_aliased_buckets
  bucket = "aleatoric-bucket-${random_pet.optional_bucket_name.id}"
}