resource "null_resource" "test" {
  count = var.quantity
  triggers = {
    trigger = timestamp()
  }
}

variable "quantity" {
  type        = number
  description = "Number of resources to be created"
}

resource "null_resource" "custom" {
  count = 2
}

#comment
