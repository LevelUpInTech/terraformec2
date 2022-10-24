variable "region" {
  type        = string
  default     = "us-west-2"
}

variable "ami" {
  type        = string
  default     = "ami-026b57f3c383c2eec"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
}

variable "tag" {
  type        = string
  default     = "acoop_instance"
}
