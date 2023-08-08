resource "null_resource" "name" {
  
}

resource "random_pet" "name" {
  keepers = {
    keeper1 = var.one
    keeper2 = var.two
  }
}

variable "one" {
  default = "some default string 1111111111111111"
}

variable "two" {
  type = number
  default = 2222
}

#comment