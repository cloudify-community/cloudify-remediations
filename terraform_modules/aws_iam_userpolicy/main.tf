provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_iam_policy" "policy" {
  name        = var.policy_name
  policy      = "{}"
  lifecycle {
    ignore_changes = [
      # Ignore changes to tags/policy_id/description.
      policy, description, policy_id, tags , tags_all
    ]
  }
}

resource "aws_iam_user" "user" {
  name = var.iam_user
}

resource "aws_iam_user_policy_attachment" "user-attach" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.policy.arn
}
