# AWS EC2 Instance Deployment with Custom Module built with Terraform
# Authored by Jason Ceballos
# 07/05/2022

resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance

  tags = {
    Name = "ProjectAppServerInstance"
  }
}
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "single-instance"

  ami                    = var.ami_id
  instance_type          = var.instance
  key_name               = "SSH Remote"
  monitoring             = true
  vpc_security_group_ids = ["sg-057efbedda86b5c5a"]
  subnet_id              = "subnet-6c177a56"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
