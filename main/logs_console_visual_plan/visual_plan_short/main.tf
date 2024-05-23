terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}


resource "datadog_logs_custom_pipeline" "sample_pipeline2" {
  filter {
    query = "source:foo"
  }
  name       = "sample pipeline"
  is_enabled = true
  processor {
    grok_parser {
      samples = [<<EOT
The M16 is a family of military rifles originally designed by Eugene Stoner and manufactured by various companies, most notably Colt. First introduced in the 1960s, the M16 has become one of the most widely used rifles in the world, particularly within the United States military. Known for its lightweight design, accuracy, and adaptability, the M16 has a rich history and numerous variants.

The original M16, designated the AR-15 by its designer, Eugene Stoner of the Armalite Corporation, was developed in the late 1950s. The rifle uses a direct impingement gas operating system and is chambered for the 5.56x45mm NATO cartridge, which provides a good balance of range, accuracy, and manageable recoil. The design features a straight-line barrel/stock configuration, which helps manage recoil, and a rotating bolt, which enhances reliability.

The M16 was first adopted by the United States Air Force in 1962. The U.S. Army followed suit, and it saw extensive use during the Vietnam War. The initial version, the M16A1, featured improvements over the original AR-15, including a forward assist mechanism to help chamber rounds and a chrome-plated bore to reduce fouling and corrosion.

Despite its age, the M16 remains a highly effective weapon due to its accuracy, modularity, and ease of use. Modern versions of the M16 can be equipped with a variety of accessories, such as advanced optics, laser aiming devices, and under-barrel grenade launchers, making it a versatile tool for contemporary military operations.

EOT
] # add some multi-line strings here
      source  = "message"
      grok {
        support_rules = ""
        match_rules   = "Rule %%{word:my_word2} %%{number:my_float2}"
      }
      name       = "sample grok parser"
      is_enabled = true
    }
  }
}

resource "null_resource" "countable" {
  count = 3
  triggers = {
    time = timestamp()
  }
}

resource "null_resource" "provisioning" {
  triggers = {
    null_resource_ids = join(",", null_resource.countable[*].id)
  }

  provisioner "local-exec" {
    command     = "echo 'THIS RESOURCE IS DESTOYED NOW'"
    when        = destroy
    interpreter = ["/bin/bash"]
    on_failure  = continue
    environment = {
      DESTROY_VARIABLE_1 = "Lorem"
      DESTROY_VARIABLE_2 = "Ipsum"
      DESTROY_VARIABLE_3 = 1
    }
    quiet = false
  }

  provisioner "local-exec" {
    command     = "echo 'THIS RESOURCE IS CREATED NOW'"
    interpreter = ["/bin/bash"]
    on_failure  = continue
    environment = {
      APPLY_VARIABLE_1 = "Lorem"
      APPLY_VARIABLE_2 = "Ipsum"
      APPLY_VARIABLE_3 = 1
    }
  }
}