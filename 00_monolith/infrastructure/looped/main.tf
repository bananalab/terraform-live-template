# Declarative approaches can implement loops to reduce code duplication.
# Pros:
#   More concise than pure declarative.
#   Reduces code duplication (DRY).
# Cons:
#   Providers must be the same.
#   Module source must be the same (e.g. versions)

locals {
    environments = {
        dev = {
            asg_instance_type = "t2.micro"
            asg_max_instances = 1
        }
        prod = {
            asg_instance_type = "t2.micro"
            asg_max_instances = 5
        }
    }
}

module "environments" {
    for_each = local.environments
    source = "github.com/bananalab/bananalab-modules//modules/bananalab-platform"
    name               = each.key
    asg_instance_type  = each.value.asg_instance_type
    asg_max_instances  = each.value.asg_max_instances
    availability_zones = ["us-west-1b", "us-west-1c"]
    domain_name        = "bananalab.dev"
}
