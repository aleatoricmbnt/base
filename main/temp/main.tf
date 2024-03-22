terraform {
  required_providers {
    scalr = {
      source = "scalr/scalr"
    }
  }
}

provider "scalr" {
  
}

resource "null_resource" "always_replaced" {
  count = 500
  triggers = {
    current_time = timestamp()
  }
}

resource "scalr_workspace" "cli" {
  count = 25
  name = "w3s_${count.index}"
  environment_id = "env-v0oa3vc08ek0pvau7"
}
