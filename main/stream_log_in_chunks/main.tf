resource "null_resource" "tip" {
  triggers = {
    time = timestamp()
  }
  provisioner "local-exec" {
    command = "echo 'Use custom hook to execute stream_log.py' && echo 'Control the size of log with TOTAL_SIZE_MB and CHUNK_SIZE_KB'"
  }
}

output "notes" {
  value = <<EOT
  Script file 'stream_log.py' is placed in the same working direcotry. 
  Call it via custom hook on the needed stage (pre-/post-plan or pre-/post-apply). 
  Total size of the custom hook log can be controlled via TOTAL_SIZE_MB shell variable and size of the chunk it would generate is controlled via CHUNK_SIZE_KB.  
  EOT
}
