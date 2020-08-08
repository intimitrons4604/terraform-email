provider "aws" {
  version = "~> 3.0"
  region  = "us-west-2"
}

data "terraform_remote_state" "dns" {
  backend = "remote"
  config = {
    hostname     = "app.terraform.io"
    organization = "intimitrons"
    workspaces = {
      name = "dns-prod"
    }
  }
}
