resource "terraform_data" "with_updatable_input" {
  input = var.update_input
}

resource "terraform_data" "with_updatable_trigger" {
  triggers_replace = var.update_trigger
}

resource "null_resource" "depends_on_updatable_trigger_resource" {
  depends_on = [ terraform_data.with_updatable_trigger ]
}

resource "random_password" "updatable_map_keys_with_for_each_expression" {
  for_each = var.update_map
  length = each.value
}

resource "null_resource" "to_be_replaced_manually" {
  
}

resource "terraform_data" "updatable_count" {
  count = var.update_count
}

# resource "terraform_data" "to_be_commented_resource" {
#   # comment me when needed
# }

resource "terraform_data" "deletable_count" {
  # count = var.update_count # delete me when needed
}

# module "to_be_commented_module" {
#   source = "github.com/aleatoricmbnt/flat/" # comment me when needed
# }

resource "terraform_data" "to_be_tainted" {
  # taint me when needed
}