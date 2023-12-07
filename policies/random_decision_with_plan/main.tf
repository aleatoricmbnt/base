resource "random_string" "some_string" {
  length = 128
  keepers = {
    time = formatdate("DDMMYYYY-HHmm", timestamp())
  }
}

resource "null_resource" "nr" {

}
