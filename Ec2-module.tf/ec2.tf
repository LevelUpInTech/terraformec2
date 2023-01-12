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
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

resource "random_string" "random" {
  count = var.instance_count
  length = 4
  special = false
  upper = false
}

resource "aws_instance" "app_server" {
  ami = var.ami_id
  instance_type = var.instance_type
  count = var.instance_count

  tags = {
    Name = appserver-instance-aw${random_string.random[count.index].result}"
  }
}