terraform {
  source = "../w_config" 
}

inputs = {
  input = "w/o config input"
  triggers_replace = "change to trigger replace"
}