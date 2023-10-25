dependency "transit_gateway" {
  config_path = "${get_terragrunt_dir()}/../../../../../shared/route53/_global/zones"
}

terraform {
  source = "github.com/bananalab/bananalab-modules//modules/bananalab-platform?ref=${local.environment_vars.locals.module_version}"
}

locals {
  environment_vars  = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  boot_script = <<-EOT
    !/bin/bash -uex

    # Install aws cli
    yum update -y && yum install -y jq unzip
    _tmp=$(mktemp -d)
    pushd $_tmp
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    ./aws/install --update
    echo 'Done.'
  EOT
}

inputs = {
  name               = local.environment_vars.locals.name
  asg_instance_type  = local.environment_vars.locals.asg_instance_type
  asg_max_instances  = local.environment_vars.locals.asg_max_instances
  availability_zones = local.region_vars.locals.availability_zones
  boot_script        = local.boot_script
  domain_name        = local.environment_vars.locals.domain_name
}