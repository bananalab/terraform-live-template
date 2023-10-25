locals {
  name              = "dev"
  asg_instance_type = "m6i.4xlarge"
  asg_max_instances = 5
  domain_name       = "bananalab.dev"
  module_version    = "main"
  stage             = "Development"
}