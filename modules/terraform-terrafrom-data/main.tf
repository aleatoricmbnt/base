resource "terraform_data" "that" {
  count = var.quantity
  input = var.data_input
}

variable "quantity" {
  
}

variable "data_input" {
  
}

#dfjgklfdl
