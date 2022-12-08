#initiating aws to be our terraform provider 
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0" #updated our aws version
    }
  }
  #updated terraform version
  required_version = "~> 1.3.0" #updated our terraform version
}
#Set configurations for our aws resources environment
provider "aws" {
  profile = "default"
  region  = "us-east-2"
}
