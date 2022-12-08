variable "ami" {
  description = "The ami our instance will be using"
  type        = string
  default     = "ami-0beaa649c482330f7"
}

variable "instance_type" {
  description = "the instance type we will use"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "The name of our instane"
  type        = string
  default     = "MyInstance"
}