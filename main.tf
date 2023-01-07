#-----root_ec2/main.tf-----
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}
module "compute" {
  source = ".module/compute"
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"
  sg =  module.security.HTTP_allow
  tag_name =      "EC2forserver"
  user_data =  ""
}


module "security" {
  source = "./module/security"
}
