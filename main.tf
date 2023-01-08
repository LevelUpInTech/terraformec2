# Root Module
# Terraform-Module-Project/main.tf

module "ec2-deployment" {
  source = "/home/ubuntu/environment/Terraform-Modules-Project/ec2-deployment" # very important 
}
