resource "terraform_data" "recreate_trigger" {
  triggers_replace = {
    timestamp = timestamp()
  }
}

data "local_file" "file_3mb" {
  filename = "${path.module}/file_3mb.txt"
}

data "local_file" "file_4mb" {
  filename = "${path.module}/file_4mb.txt"
}

data "local_file" "file_5mb" {
  filename = "${path.module}/file_5mb.txt"
}

output "file_3mb" {
  value = data.local_file.file_3mb.content
}

output "file_4mb" {
  value = data.local_file.file_4mb.content
}

output "file_5mb" {
  value = data.local_file.file_5mb.content
}