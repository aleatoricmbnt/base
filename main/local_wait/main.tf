variable "sleep_time" {
  default = 1
}

resource "null_resource" "nr" {
  triggers = {
    trigger = timestamp()
  }
  provisioner "local-exec" {
    command = "sleep ${var.sleep_time}"
  }
}

resource "random_pet" "rp" {
  keepers = {
    keeper = timestamp()
  }
}

output "sleep_time" {
  value     = var.sleep_time
  sensitive = false
}

output "long" {
  value = "The Adepta Sororitas, colloquially called the 'Sisterhood', whose military arm is also known as the Sisters of Battle and formerly as the Daughters of the Emperor, are an all-female division of the Imperium of Man's state church known as the Ecclesiarchy or, more formally, as the Adeptus Ministorum. The Sisterhood's Orders Militant serve as the Ecclesiarchy's armed forces, mercilessly rooting out spiritual corruption and heresy within Humanity and every organisation of the Adeptus Terra. There is naturally some overlap between the duties of the Sisterhood and the Imperial Inquisition; for this reason, although the Inquisition and the Sisterhood remain entirely separate organisations, the Orders Militant of the Adepta Sororitas also act as the Chamber Militant of the Inquisition's Ordo Hereticus. The Adepta Sororitas and the Sisters of Battle are commonly regarded as the same organisation, but the latter title technically refers only to the Orders Militant of the Adepta Sororitas, the best-known part of the organisation to the Imperial public."
}

output "sensitive" {
  value       = "Sensitive value that shouldn't be exposed"
  description = "Sensitive output"
  sensitive   = true
}

output "run_time" {
  value = timestamp()
}

output "workspace_name" {
  value = terraform.workspace
}

resource "terraform_data" "PR_check" {
  input = "PR_check"
  triggers_replace = timestamp()
}