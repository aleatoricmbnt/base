module "referencing" {
  source = "github.com/aleatoricmbnt/base.git//config_tests/module_sources/module_github_com"
}


module "smth_from_git" {
  source = "github.com/aleatoricmbnt/flat/"
}