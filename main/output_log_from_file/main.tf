resource "null_resource" "tip" {
  triggers = {
    time = timestamp()
  }
  provisioner "local-exec" {
    command = "echo 'Use custom hook to execute output_log.py' && echo 'Control the size of log with TOTAL_SIZE_KB'"
  }
}

output "notes" {
  value = <<EOT
  Script file 'output_log.py' is placed in the same working direcotry. 
  Call it via custom hook on the needed stage (pre-/post-plan or pre-/post-apply). 
  Total size of the custom hook log can be controlled via TOTAL_SIZE_KB shell variable.  
  EOT
}