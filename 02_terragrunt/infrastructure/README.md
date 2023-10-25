# Terragrunt

Terragrunt is a tool designed to keep your Terraform code DRY.
It uses a custom variant of HCL to define common configuartion
in a hierarchical repository.

To deploy this configuration run:

```bash
cd infrastructure/platform
terragrunt run-all apply 
```