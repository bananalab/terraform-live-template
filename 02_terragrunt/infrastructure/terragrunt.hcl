locals {
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  account_name     = local.account_vars.locals.account_name
  account_id       = local.account_vars.locals.aws_account_id
  aws_region       = local.region_vars.locals.aws_region
  global_tags = {
                  Terraformed = true
                  Stage =  "${title(local.environment_vars.locals.stage)}"
                  TerraformState = "${path_relative_to_include()}/terraform.tfstate"
                }
  default_tags = merge(
    local.global_tags,
    lookup(local.account_vars.locals, "default_tags", {}),
    lookup(local.region_vars.locals, "default_tags", {}),
    lookup(local.environment_vars.locals, "default_tags", {})
  )
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "terraform-state-${local.account_id}-${local.aws_region}"

    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    provider "aws" {
        region = "${local.aws_region}"
        allowed_account_ids = ["${local.account_id}"]
        default_tags {
            tags = {
              %{ for k,v in local.default_tags }
              ${k} = "${v}"
              %{ endfor }
            }
        }
    }
  EOF
}
