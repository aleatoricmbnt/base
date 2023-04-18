module "referencing" {
  source = "git::https://alea-gitlab.home.shytse.com/aleatoric/base.git//main/git_https_target"
}

output "referencing_module_id_from_output" {
  value = module.referencing.outputs.null_resource_id
}