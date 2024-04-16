resource "null_resource" "test" {
  count = var.quantity
  # triggers = {
  #   trigger = timestamp()
  # }
}

variable "quantity" {
  type        = number
  description = "Number of resources to be created"
}

resource "random_pet" "name" {
  keepers = {
    null_id = null_resource.test[1].id
  }
}