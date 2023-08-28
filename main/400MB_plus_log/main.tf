resource "null_resource" "generate_file" {
  provisioner "local-exec" {
    command = "python 400mb.py"
  }
}

resource "null_resource" "display_file" {
  depends_on = [ null_resource.generate_file ]
  provisioner "local-exec" {
    command = "cat 409600.txt"
  }
}