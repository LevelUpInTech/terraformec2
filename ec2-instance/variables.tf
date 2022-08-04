#---ec2-instance/variables.tf---

variable "ami_id" {
  type = string
  default = "ami-830c94e3"
 }
 
 variable "instance_type" {
     type = string
     default = "t2.micro"
 }
 
 variable "region" {
     type = string
     default = "us-west-2"
 }