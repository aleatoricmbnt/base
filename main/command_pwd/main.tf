resource "null_resource" "script_pwd" {
  triggers = {
    current_time = (formatdate("YYYY-MM-DD_hh:mm:ss",timestamp()))
  }
  provisioner "local-exec" {
    command = "chmod a+x script.sh && ./script.sh"
  }
}

data "local_file" "read_script" {
  depends_on = [null_resource.script_pwd]
  filename   = "./script_result.txt"
}

resource "null_resource" "object_pwd" {
  triggers = {
    current_time = (formatdate("YYYY-MM-DD_hh:mm:ss",timestamp()))
  }
  provisioner "local-exec" {
    command = "echo ${path.cwd} > object_pwd.txt"
  }
}

data "local_file" "read_object_pwd" {
  depends_on = [null_resource.object_pwd]
  filename   = "./object_pwd.txt"
}


resource "null_resource" "object_module" {
  triggers = {
    current_time = (formatdate("YYYY-MM-DD_hh:mm:ss",timestamp()))
  }
  provisioner "local-exec" {
    command = "echo ${path.module} > object_module.txt"
  }
}

data "local_file" "read_object_module" {
  depends_on = [null_resource.object_module]
  filename   = "./object_module.txt"
}

resource "null_resource" "object_root" {
  triggers = {
    current_time = (formatdate("YYYY-MM-DD_hh:mm:ss",timestamp()))
  }
  provisioner "local-exec" {
    command = "echo ${path.root} > object_root.txt"
  }
}

data "local_file" "read_object_root" {
  depends_on = [null_resource.object_root]
  filename   = "./object_root.txt"
}


output "pwd_results" {
  value = "script: ${data.local_file.read_script.content}object_pwd: ${data.local_file.read_object_pwd.content}object_module: ${data.local_file.read_object_module.content}object_root: ${data.local_file.read_object_root.content}"
}