module "sheed_ec2" {
  source        = "./ec2"
    instance_type = "t2.micro"
    ami_id = "ami-0022f774911c1d690"
}
