variable "aws_region" {
  type = string
  description = "AWS region to launch servers."
}

variable "access_key" {
  type = string
  description = "Access key for AWS"
}

variable "secret_key" {
  type = string
  description = "Secret key for AWS"
}

variable "vm_profile" {
  type = string
  description = "vm profile name"
}

variable "ami" {
  type = string
  description = "ec2 ami value"
}

variable "instance_type" {
  type = string
  description = "ec2 instance type"
}
