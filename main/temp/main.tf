resource "terraform_data" "this" {
  input = [ "var.input, var.input2", "kek" ]
  triggers_replace = timestamp()
}
