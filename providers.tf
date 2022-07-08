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
  region  = var.region
}

# Terraform Cloud   
terraform {
  cloud {
    organization = "www-mclark"

    workspaces {
      name = "ProjectWk21_AWS_ECS_Repeatable_Infrastructure"
    }
  }
}