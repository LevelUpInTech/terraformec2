#--- module-ec2/providers.tf
#create variables for all of module-ec2
#child module for ec2 variables.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
#   required_version = ">= 0.14.9"
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}