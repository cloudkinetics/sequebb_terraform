# data "aws_iam_policy_document" "config_policy" {
#   statement {
#     effect  = "Allow"
#     actions = ["s3:*"]
#     resources = [
#       aws_s3_bucket.config_bucket.arn,
#       "${aws_s3_bucket.config_bucket.arn}/*"
#     ]
#   }
# }
