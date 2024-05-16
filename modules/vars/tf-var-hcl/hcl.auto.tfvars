locations = <<-EOT
{
  "AIMS" = {
    cidr     = "10.162.40.0/22"
    zone     = "abc"
    tags     = {
      environment = "DR"
      project = "InterPac"
    }
    cidr_app = "10.162.40.0/24"
    gw_app   = "10.162.40.1"
    cidr_db = "10.162.41.0/24"
    gw_db   = "10.162.41.1"
  }
}
EOT

length-hcl = 18
bool-hcl = true