terraform {
  source = "./" 
}

inputs = {
  input = ["string value of the array", 237, true]
  triggers_replace = {
    name     = "some_entity"
    config = {
      description = "Test description of the entity"
      number_of_smth  = 64
      smth_enabled = true
    }
    tags = ["test", "terragrunt", "other"]
  }
}