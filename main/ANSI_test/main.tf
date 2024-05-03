resource "null_resource" "some" {
    triggers = {
        time = timestamp()
    }
}