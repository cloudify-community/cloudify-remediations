provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_iam_instance_profile" "vm_profile" {
  name = var.vm_profile
}

resource "aws_instance" "vm" {
  ami = var.ami
  instance_type = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.vm_profile.id
  lifecycle {
    ignore_changes = [
      # Ignore changes to tags and user_data
      tags, user_data, user_data_replace_on_change
    ]
  }
}
