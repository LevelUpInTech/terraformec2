#--- module-ec2/variables.tf
# Create variable for aws_region
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "ami_id" {
  type    = string
  default = "ami-0ceecbb0f30a902a6" #-- us-west-2 ami id
}

variable "instance" {
  type    = string
  default = "t2.micro"
}

variable "cidr" {
  type = string
  default = "10.0.1.0/24"
}

variable "az" {
  type = string
  default = "us-west-2a"
}