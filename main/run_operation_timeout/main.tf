resource "terraform_data" "name" {
    count = 30
    triggers_replace = timestamp()
    
    provisioner "local-exec" {
        command = "sleep 120"
    }
}