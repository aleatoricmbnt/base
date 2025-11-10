resource "terraform_data" "this" {
  input = [ "kek", "var.input, var.input2", "kek" ]
  triggers_replace = timestamp()
}
