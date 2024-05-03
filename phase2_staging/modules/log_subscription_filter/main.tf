# Create CloudWatch Event Target to send events to CloudWatch Logs
resource "aws_cloudwatch_log_subscription_filter" "subscription_filter" {
  count =   length(var.log_subscription_filter_name)
  role_arn        = "arn:aws:iam::471112567185:role/aws_sftp_role"
  name            = var.log_subscription_filter_name[count.index]
  log_group_name  = var.log_subscription_group_name[count.index]
  filter_pattern = ""
  destination_arn = var.log_subscription_filter_destination_arn[count.index]
}


# # Define IAM policy document for log subscription, AWS Config rule, and security group modification


# # Create IAM policy for log subscription, AWS Config rule, and security group modification
# resource "aws_iam_policy" "subscription_policy" {
#   name        = "log_subscription_config_security_policy"
#   policy      = data.aws_iam_policy_document.subscription_policy.json
# }

# # Create IAM role for log subscription with the attached policy
# resource "aws_iam_role" "log_subscription_role" {
#   name               = "log_subscription_role"
#   assume_role_policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [{
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "logs.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }]
#   })
# }

# # Attach IAM policy to IAM role
# resource "aws_iam_role_policy_attachment" "subscription_policy_attachment" {
#   role       = aws_iam_role.log_subscription_role.name
#   policy_arn = aws_iam_policy.subscription_policy.arn
# }
# data "aws_iam_policy_document" "subscription_policy" {
#   statement {
#     effect = "Allow"

#     # Allow creating log subscription filters
#     actions   = ["logs:PutSubscriptionFilter"]
#     resources = ["arn:aws:logs:*:*:*"]

#     # Allow describing and updating AWS Config rules
#     actions += [
#       "config:Get*",
#       "config:List*",
#       "config:Put*",
#       "config:Delete*",
#     ]
#     resources += ["*"]

#     # Allow modifying security groups
#     actions += [
#       "ec2:AuthorizeSecurityGroupEgress",
#       "ec2:AuthorizeSecurityGroupIngress",
#       "ec2:CreateSecurityGroup",
#       "ec2:DeleteSecurityGroup",
#       "ec2:RevokeSecurityGroupEgress",
#       "ec2:RevokeSecurityGroupIngress",
#     ]
#     resources += ["*"]
#   }
# }
