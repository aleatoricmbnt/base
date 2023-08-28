resource "null_resource" "generate_file" {
  provisioner "local-exec" {
    command = "python 110kb.py"
  }
}

resource "null_resource" "display_file" {
  depends_on = [ null_resource.generate_file ]
  provisioner "local-exec" {
    command = "cat 110.txt"
  }
}