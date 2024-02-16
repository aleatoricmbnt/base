resource "null_resource" "script_pwd" {
  triggers = {
    current_time = (formatdate("YYYY-MM-DD_hh:mm:ss",timestamp()))
  }
  provisioner "local-exec" {
    command = "./script.sh"
  }
}

resource "null_resource" "object_pwd" {
  triggers = {
    current_time = (formatdate("YYYY-MM-DD_hh:mm:ss",timestamp()))
  }
  provisioner "local-exec" {
    command = "echo ${path.pwd} > echo_result.txt"
  }
}

data "local_file" "read_script" {
  depends_on = [null_resource.script_pwd]
  filename   = "./script_result.txt"
}

data "local_file" "read_echo" {
  depends_on = [null_resource.object_pwd]
  filename   = "./echo_result.txt"
}

output "comparison" {
  value = "script: ${data.local_file.read_script.content} || echo: ${data.local_file.read_echo.content}"
}