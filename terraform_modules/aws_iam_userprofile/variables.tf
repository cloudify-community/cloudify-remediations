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

variable "iam_user" {
  type = string
  description = "iam user to delete user_login_profile"
}
