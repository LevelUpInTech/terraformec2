provider "aws" {
  region = var.aws_region
}


module "ec2" {
  source = "/../.."
}
