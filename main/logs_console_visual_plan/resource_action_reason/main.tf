resource "terraform_data" "with_updatable_input" {
  input = var.update_input
}

resource "terraform_data" "with_updatable_trigger" {
  triggers_replace = var.update_trigger
}

resource "terraform_data" "new_depends_on_updatable_trigger_resource" {
  triggers_replace = [terraform_data.with_updatable_trigger]
}

moved {
  from = terraform_data.depends_on_updatable_trigger_resource
  to = terraform_data.new_depends_on_updatable_trigger_resource1
}

resource "terraform_data" "updatable_map_keys_with_for_each_expression" {
  for_each = var.update_map
  input = each.value
}

resource "null_resource" "to_be_replaced_manually" {
  
}

resource "terraform_data" "updatable_count" {
  count = var.update_count
}

resource "terraform_data" "to_be_commented_resource" {
  # comment me when needed
}

resource "terraform_data" "deletable_count" {
  count = var.update_count # delete me when needed
}

module "to_be_commented_module" {
  count = 1
  source = "./subdir" # comment me IN THE MODULE REPO when needed
}

resource "random_string" "name" {
  length = 12
}

resource "terraform_data" "to_be_tainted" {
  # taint me when needed
}

variable "revision" {
  default = 1
}

resource "terraform_data" "replacement" {
  input = var.revision
}

# This resource has no convenient attribute which forces replacement,
# but can now be replaced by any change to the revision variable value.
resource "terraform_data" "test" {
  lifecycle {
    replace_triggered_by = [terraform_data.replacement]
  }
}