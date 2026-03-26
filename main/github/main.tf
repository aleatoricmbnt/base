terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

resource "github_repository" "test" {
  name        = "tf-provider-test-delete-me"
  description = "Scalr provider config test"
  visibility  = "public"
}
