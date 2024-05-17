variable "string_with_symbols" {
  
}

resource "null_resource" "name" {
  triggers = {
    trigger = var.string_with_symbols
  }
}