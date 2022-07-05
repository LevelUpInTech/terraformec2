# AWS EC2 Instance Deployment with Custom Module built with Terraform
# Authored by Jason Ceballos
# 07/05/2022

resource "aws_instance" "project_server" {
  ami           = var.ami_id
  instance_type = var.instance

  tags = {
    Name = "ProjectServerInstance"
  }
}