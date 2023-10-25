include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "tfr://registry.terraform.io/terraform-aws-modules/route53/aws//modules/zones?version=2.10.2"
}

inputs = {
  zones = {
    "bananalab.dev" = {}
  }
}
