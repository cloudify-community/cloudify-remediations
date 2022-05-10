provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_iam_user_login_profile" "user_login_profile" {
  user    = var.iam_user
}
