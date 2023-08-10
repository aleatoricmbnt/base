resource "random_integer" "color_list" {
  count = 3
  keepers = {
    conditional = var.question != "yes" ? "unchanged string" : timestamp()
    }
  min = 0
  max = 255
}

resource "local_file" "color_script" {
  content  = <<EOT
#!/bin/bash

# Define RGB color values
RED=${random_integer.color_list[0].id}
GREEN=${random_integer.color_list[1].id}
BLUE=${random_integer.color_list[2].id}

# String to be highlighted
STRING="I AM COLORED WOW!!!"

# ANSI escape codes for RGB color
COLOR="\033[38;2;$${RED};$${GREEN};$${BLUE}m"
RESET="\033[0m"

# Display the highlighted string
echo -e "$${COLOR}$${STRING}$${RESET}"
  EOT
  filename = "./showcolor.sh"
}

resource "null_resource" "show_color" {
  triggers = {
    new_list = random_integer.color_list[1].id
  }
  depends_on = [ local_file.color_script ]
  provisioner "local-exec" {
    command = "chmod +x showcolor.sh && ./showcolor.sh"
  }
}

variable "question" {
  default = "no"
  type = string
  description = "Do you want your config to be applied again during re-run?"
}

output "random_int_list" {
  value = join(",", random_integer.color_list[*].id)
}
