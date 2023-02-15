#--- root/variables.tf

variable "ami_id" {
  description = "ec2 ami_id"
  type        = string
  default     = "ami-033cfb3e88287e319"
}

variable "instance" {
  description = "instance type"
  type        = string
  default     = "t2.micro"
}

variable "region" {
  description = "instance region"
  type        = string
  default     = "us-east-1"
}