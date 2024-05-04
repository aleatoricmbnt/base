resource "null_resource" "long_attribute_names" {
  triggers = {
    time = timestamp()
    long-attribute-name-approx-fourty-one-symbol = var.trigger-value
  }
}

variable "trigger-value" {
  type = string
}