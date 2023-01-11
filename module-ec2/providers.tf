#--- module-ec2/providers.tf
# provider is not needed if you already declared it in root
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}