resource "null_resource" "no_vars" {
  triggers = {
    "timestamp" = timestamp()
  }
}

resource "null_resource" "check_ip" {
  triggers = {
    variable_trigger = var.my-very-specific-var
  }
}

variable "my-very-specific-var" {
  
}
