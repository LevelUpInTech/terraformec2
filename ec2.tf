module "ec2_multi_use" {
  source = "./ec2_multi_use"
}

terraform {
cloud {
    organization = "www-mclark"

    workspaces {
      name = "ProjWK21"
    }
  }
}
