terraform {
  backend "s3" {
    bucket         = "330673892428-tfstate"
    key            = "aws-tf-multiple-accounts.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    # dynamodb_table = "terraform-locks"

    role_arn = "arn:aws:iam::330673892428:role/terraform-role"
  }
}