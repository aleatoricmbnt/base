terraform {
    required_providers {
        scalr = {
            source = "registry.scalr.io/scalr/scalr"
            version= "> 1.0.0"
        }
    }
}

# ----------------------------------------------------------------------------------------- #

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
    command = "echo 'THIS RESOURCE IS DESTOYED NOW'"
    when = destroy
    interpreter = [ "/bin/bash" ]
    on_failure = continue
    environment = {
      DESTROY_VARIABLE_1 = "Lorem"
      DESTROY_VARIABLE_2 = "Ipsum"
      DESTROY_VARIABLE_3 = 1
    }
    quiet = false
  }

  provisioner "local-exec" {
    command = "echo 'THIS RESOURCE IS CREATED NOW'"
    interpreter = [ "/bin/bash" ]
    on_failure = continue
    environment = {
      APPLY_VARIABLE_1 = "Lorem"
      APPLY_VARIABLE_2 = "Ipsum"
      APPLY_VARIABLE_3 = 1
    }
  }
}

# ----------------------------------------------------------------------------------------- #

resource "terraform_data" "replace_trigger" {
  input = var.basic
}

resource "random_string" "long_id_string" {
  length = 1024 # characters
  lower = true
  numeric = true
  special = true
  upper = true
  min_lower = 64
  min_numeric = 64
  min_special = 64
  min_upper = 64
  override_special = <<EOT
    CeeF2TzvB@burp0EorS914cbeWA9wn*=
    URpcah*JSo@3q13xZvp$ZmnBfp@okaTO
    rrAbvkQ!Gc$PWeDm9H&42@ZT@7#t!j#+
    ER@ekXud58%%b&f+3Ecj7yuYej469jAh
    %@NY$CTMSNo*YaK6mB%S#1&Ns$+QN#Qe
    Dsrj6O8NQosfwh!FP&2Bnvz8Yr6AD2@R
    Kht@jwWhO0VoC%@K8rQZ4!HY096ajx0$
    76n$jn5WNNuST!@$FEp8Zd@eapYMnHsx
    @#V9vDTNvKfhgzgZhO8+ukFERy*K+2u%
    G2B$2g1z#U1jst&gkVGeSm4wA6pJ%M%s
    TNnd3cPsCPAW9bM7rZDT3K76aZShuve8
    dqE8yyNaxv4vbkWoqb7e0#D0P@5!uAXo
    uR*fP0vwG+*1Uo37dFx#H6Bea86xAg6N
    RujKnROothsCg$gqo4YDJyyoF%mbgjT2
    9g!9PQpvRKAS9ABX&TTV+wNx!TBymEc3
    !$ONb&vYjXu0eMVCR=&DK*XMJ+rG&y=d
    $Kk1@HfkmsCx82NvBj&3Usja5@eX2Dpm
    !$$F0bvpc5BPeaH&B8e62$Xr54D*Y*%M
    oDK+oDT@KTXt=ACQkEEQJjnee0Ka0Xoy
    MY0MU!9prR=yODEE%v*$xpdGVMhobOeb
    aY5MZCKOX1nY!*AsXQTo5PRgYx%YAax&
    Nvo6JXR$*Ut0pa@mA9K=$REFxE$5ru+q
    r$JmZphE&ZqUk2sJeBVEufEVOeGUhO#t
    =y=WpWJBMVznrJ+Ds#c+OFvPPBBaqdxt
    H%pY9tcV$+@&*!ZbV6P%A6u4QVReR3hV
    KGJ+Rzt@R4w+9WC6=PS56Yo0R%Ug+1b&
    55WaSSXEu6&eKt@K09bNnHg2Xg%4gBpN
    yE++jgCwMj98QtZC$4TbHfA@Kp9#FVCX
    @PjSWcRZ=3DA@Bz&z*QvJwj%bDnuk4&S
    Qq0!!&M%Obq5NzEa3YGmmu2&MM4KwNF4
    t5+7zY0+hdXp!!0&wrykyse0mfYbgkTr
    =+9DEqaZMjr!PEhM=5YADMgn%Pw$563Q
    U+8BrfP9FZtqtCAo52Vhj&@C6Y2@Cs+h
    0Z7$&A9K1cf6uxAJk0RoK9kskZN*Muy#
    gSYfeNGu&VXuAvXRty7mQx64t&XFy&96
    0WXPQO%1x3OgKYa2sNpaXWdA$$frjYG*
    w6HdssxB3!Y5z@RYdwN!Na02%VwcKGND
    BZkQOdcZ*%3r4Tt&G6@GfB4=bc!!@Yuh
    ystX=Pb%y5wPm7%70x4Y7gDoerof17c5
    2a#od=j1JpA8*e1rasSe!ogxjz7R7SNJ
  EOT
  
  lifecycle {
    replace_triggered_by = [terraform_data.replace_trigger]
  }
}

# ----------------------------------------------------------------------------------------- #

resource "random_pet" "long-named-pet-consisting-of-words-and-characters-with-dashes-and-underscores-to-reach-a-total-length-of-200-characters-in-accordance-with-your-request-to-include-words-dashes-underscores-and-lowercase-letters" {
  length = 3
  prefix = "NNNZWANOAJAPVKHYDJBDSNUANRKBRXHQRDBCSAVKGKXHOWXYCCDCNYGFSQUGQLBYNBFFWZJPGMRAUDKBIEYMGJWERJACQIMJQOZK"
  separator = "SEPARATOR"
  keepers = {
    key-keeper = join(", ", values(var.triggers_to_be_joined))
  }
}

# ----------------------------------------------------------------------------------------- #

resource "scalr_workspace" "cli-ws_to-be-updated-on-rerun" {
  name            = "workspace_${formatdate("HH-mm-ss", timestamp())}"
  environment_id  = var.env-id

  working_directory = "example/path"
  auto_apply = true
  auto_queue_runs = "never"
  force_latest_run = false
  var_files = ["some-variables-file-with-aabsurdly-long-name.tfvars.json"]
  deletion_protection_enabled = false
  hooks {
    pre_init = "printenv"
    pre_plan = "some long string that won't be valid as a custom hook but still can be used for tests"
    pre_apply = "YO 1337"
  }
}

# ----------------------------------------------------------------------------------------- #

resource "random_password" "sensitive_values_as_keepers" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
  keepers = {
    credentials = join("/", values(var.secrets))
  }
}