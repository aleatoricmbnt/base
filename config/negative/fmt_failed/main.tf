resource "terraform_data" "x" {
  input = "value"
  triggers_replace = [ timestamp() ]
}