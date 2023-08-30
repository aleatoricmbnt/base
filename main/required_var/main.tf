resource "null_resource" "triggered_by_var" {
  triggers = {
    var = var.trigger
  }
}

variable "trigger" {
  
}