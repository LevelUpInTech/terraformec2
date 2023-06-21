variable "ami_id" {
    type = string
    default = "ami-0e820afa569e84cc1"
}

variable "instance" {
    type = string
    default = "t2.micro"
}

variable "tag_name" {
    type = string
    default = "ProjectEC2"
}