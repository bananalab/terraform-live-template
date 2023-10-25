# A declarative live deployment has separate resource and module declarations for each environment.
# All attributes must be specified for each.
# Pros:
#   Explicit.
#   All attributes can be managed independently (e.g. module versions, providers, etc.).
# Cons:
#   Doesn't scale.
#   Not "DRY".
#
# Deploy this configuration using standard Terraform workflow:
#   `terraform init`
#   `terraform plan -out plan.tfplan`
#   `terraform apply plan.tfplan`
# Remeber to destroy the resources:
#   `terraform destroy`

module "prod" {
    source = "github.com/bananalab/bananalab-modules//modules/bananalab-platform"
    name               = "prod"
    asg_instance_type  = "t2.micro"
    asg_max_instances  = 5
    availability_zones = ["us-west-1b", "us-west-1c"]
    domain_name        = "bananalab.dev"
}

module "dev" {
    source = "github.com/bananalab/bananalab-modules//modules/bananalab-platform"
    name               = "dev"
    asg_instance_type  = "t2.micro"
    asg_max_instances  = 1
    availability_zones = ["us-west-1b", "us-west-1c"]
    domain_name        = "bananalab.dev"
}