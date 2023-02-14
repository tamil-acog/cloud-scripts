terraform {

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.36.2"
    }
  }
  # cloud {
  #   organization = "aganitha"
  #   hostname     = "app.terraform.io" # Optional; defaults to app.terraform.io

  #   workspaces {
  #     name = "hetzner"
  #   }
  # }
}


