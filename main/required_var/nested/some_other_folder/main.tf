resource "null_resource" "another" {
  triggers = {
    var = var.another_var
  }
}

variable "another_var" {

}