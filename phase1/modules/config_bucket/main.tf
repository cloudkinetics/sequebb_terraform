# resource "aws_iam_role_policy" "config_policy" {
#   name   = var.config_policy_name
#   role   = var.config_role
#   policy = data.aws_iam_policy_document.config_policy.json
# }
# resource "aws_s3_bucket" "config_bucket" {
#   bucket = var.config_bucket
#   force_destroy = var.config_bucket_force_destroy
# }