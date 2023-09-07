# import backend, provider from /terragrunt/root.hcl
include "root" {
  path = find_in_parent_folders("root.hcl")
}

# Indicate where to source the terraform module from.
# The URL used here is a shorthand for
# "tfr://registry.terraform.io/terraform-aws-modules/vpc/aws?version=3.5.0".
# Note the extra `/` after the protocol is required for the shorthand
# notation.
terraform {
  #source = "tfr:///terraform-aws-modules/vpc/aws?version=3.5.0"
  source = "../../terraform//sample-bucket"
}

# IAM module grants permissions to developer & terraform, so is a preprequisite for all modules
# dependency "iam" {
#   config_path  = "../iam"
#   skip_outputs = true
# }

locals {
  global_vars  = read_terragrunt_config(find_in_parent_folders("global_vars.hcl")).inputs
  account_vars = read_terragrunt_config("account_vars.hcl").inputs

  # shortcuts
  aws_account          = local.account_vars.aws_account
}

# Pass input variables (global vars + project vars + module vars defined here)
inputs = merge(local.global_vars, local.account_vars, {
  bucket_name = "${local.aws_account}-test-bucket"
})
