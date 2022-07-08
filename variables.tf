# Module/Variables

# Amazon Machine Identification
variable "ami_id" {
    type = string
    default = "ami-065efef2c739d613b"
}

# AMI Instance
variable "instance" {
    type = string
    default = "t2.micro"
}

# AMI region
variable "region" {
  description = "Region selected where environment is going to be deployed"
  type        = string
  default     = "us-east-1"
}

# # AMI Instance ID
# variable "instance" {
#   description = "ID of the EC2 instance"
#  # value = aws_instance.app_server.id
# }

# # #AMI Instance Public IP address
# variable "ip" {
#   description = "Public IP address"
# }