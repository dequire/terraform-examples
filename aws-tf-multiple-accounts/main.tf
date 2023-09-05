module "master_account_bucket" {
  source = "./sample-bucket"

  bucket_name = "multiple-accounts-bucket-master"
}

module "child_account_1_bucket" {
  providers = {
    aws = aws.child_account_1
  }

  source    = "./sample-bucket"

  bucket_name = "multiple-accounts-bucket-child-1"
}