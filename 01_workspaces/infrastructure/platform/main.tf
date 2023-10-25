# Workspaces allow a single confguration to be represented by multiple state
# files.  In addition to the root config terraform can use per deployment
# configuration in the form of variables files.
#
# Pros:
#  Concise.
#  Flexible.
# Cons:
#  Module and providers versions must be identical.
#  At scale it's easy to lose track of workspaces.
#
# Deploy this configuration specifying backend, workspace, and variable files:
#   `terraform workspace new dev`
#   `terraform init -backend-config="bucket=terraform-state-$(aws sts get-caller-identity --query='Account' --output text)-us-west-1"`
#   `terraform plan -var-file=dev.tfvar -out plan.tfplan`
#   `terraform apply plan.tfplan`
#  Repeat for the `prod` environment.
# Remeber to destroy the resources:
#   `terraform destroy`

module "platform" {
    source = "github.com/bananalab/bananalab-modules//modules/bananalab-platform"
    name               = terraform.workspace
    asg_instance_type  = var.asg_instance_type
    asg_max_instances  = var.asg_max_instances
    availability_zones = var.availability_zones
    domain_name        = var.domain_name
}