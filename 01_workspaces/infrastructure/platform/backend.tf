# The backend can be partially configured in HCL and the rest provided at init.
# This is especially handy when the workspaces are in different AWS accounts or
# regions.  To use this config run 
#   `tf init -backend-config="bucket=terraform-state-$(aws sts get-caller-identity --query='Account' --output text)-us-west-1`
terraform {
  backend "s3" {
    key    = "workspaces"
    region = "us-west-1"
  }
}