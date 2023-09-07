#!/bin/sh

find . -name .terragrunt-cache -type d -exec rm -rf {} \;
find . -name .terraform.lock.hcl -type f -exec rm {} \;