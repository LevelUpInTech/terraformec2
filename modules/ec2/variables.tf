variable "ami_id" {
  type    = string
  default = "ami-0cff7528ff583bf9a"
}

variable "instance" {
  type    = string
  default = "t2.micro"
}
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
  # Replace the region per your requirements
}
