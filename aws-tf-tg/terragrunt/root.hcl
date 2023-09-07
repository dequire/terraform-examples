
# read locals needed to parametrize provider
# note that this block will actually be evaluated in the location where terragrunt.hcl is, so find_in_parent_folders is correct
locals {
  global_vars    = read_terragrunt_config(find_in_parent_folders("global_vars.hcl"))
  account_vars   = read_terragrunt_config("account_vars.hcl")
  aws_account    = local.account_vars.inputs.aws_account
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  backend "s3" {
    bucket         = "${local.aws_account}-tfstate"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"

    role_arn = "arn:aws:iam::${local.aws_account}:role/terraform-role"
  }
}
EOF
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "eu-central-1"

  assume_role {
    role_arn = "arn:aws:iam::${local.aws_account}:role/terraform-role"
  }
}
EOF
}
