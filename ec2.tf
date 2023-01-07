#-----root_ec2/main.tf-----

module "ec2instance" {
  source = "./Modules"
}