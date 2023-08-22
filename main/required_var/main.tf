resource "null_resource" "name" {
  triggers = {
    var = var.trigger
  }
}

variable "trigger" {
  
}