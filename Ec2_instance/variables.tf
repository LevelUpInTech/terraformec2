variable "ami_id" {
    type = string
    default = "ami-09d3b3274b6c5d4aa"
}

variable "instance" {
    type = string
    default = "t2.micro"
}

variable "tag" {
    type = string
    default = "Bmoore_Instance"
}

variable "region" {
    type = string
    default = "us-east-1"
}