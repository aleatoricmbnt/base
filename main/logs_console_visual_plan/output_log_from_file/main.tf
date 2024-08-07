resource "null_resource" "tip" {
  triggers = {
    time = timestamp()
  }
  provisioner "local-exec" {
    command = "cat README.md"
  }
}

output "notes" {
  value = <<EOT
  Script file 'output_log.py' is placed in the same working direcotry. 
  Call it via custom hook on the needed stage (pre-/post-plan or pre-/post-apply). 
  Total size of the custom hook log can be controlled via TOTAL_SIZE_KB shell variable.  
  EOT
}