resource "terraform_data" "name" {
  triggers_replace = timestamp()
  provisioner "local-exec" {
    command = "sleep 120"
  }
}