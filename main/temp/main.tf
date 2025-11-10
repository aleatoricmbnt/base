resource "terraform_data" "this" {
  input = {
    key1 = "kek"
    key4 = "lol"
    keys2 = "lolkek"
  }
  triggers_replace = "2025-11-10T09:13:16Z"
}
