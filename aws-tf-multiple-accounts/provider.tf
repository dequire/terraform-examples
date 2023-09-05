provider "aws" {
  region = "eu-central-1"

  assume_role {
    role_arn = "arn:aws:iam::330673892428:role/terraform-role"
  }
}

provider "aws" {
  alias = "child_account_1"
  region = "eu-central-1"

  assume_role {
    role_arn = "arn:aws:iam::705440338798:role/terraform-role"
  }
}

provider "aws" {
  alias = "child_account_2"
  region = "eu-central-1"

  assume_role {
    role_arn = "arn:aws:iam::921046755437:role/terraform-role"
  }
}