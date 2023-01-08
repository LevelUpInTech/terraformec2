# ----ec2-instance/ec2.tf # ---------

variable "region" {
  default = "us-west-2"
}

variable "ami_id" {
  type    = string
  default = "ami-0ceecbb0f30a902a6"
}

variable "instance" {
  type    = string
  default = "t2.micro"
}