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
  region  = var.aws_region
}

resource "aws_instance" "app_server" {
  aws_ami           = data.aws_ami.amazon_linux2.id
  instance          = var.instance_type

  tags = {
    Name = "app-server-instance"
  }
}
