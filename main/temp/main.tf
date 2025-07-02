resource "null_resource" "test" {
  provisioner "local-exec" {
    command = "echo 'Testing dependency'"
  }
  
  triggers = {
    "dependency" = null_resource.missing.id
  }
}