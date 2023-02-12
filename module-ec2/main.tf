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

resource "aws_instance" "db_server" {
  ami           = var.ami_id
  instance_type = var.instance
  
  tags = {
    name = db.tag
  }
}

variable "ami_id" {
    description = "ec2 ami_id"
    type        = sting
    default     = "ami-033cfb3e88287e319"
}
    
variable "instance" {
    description = "instance type"
    type        = sting
    default     = "t2.micro"
}
    
variable "region" {
    description = "instance region"
    type        = sting
    default     = "us-east-1"
}

module "terraformec2" {
    source = "./terraform-module/terraformec2/"
}

output " " {
    description = "ec2 public ip"
    value =aws_instance.db_server.public_ip
}

output "ec2_tags" {
    value = aws_instance.db_server.tags_all.Name
}
