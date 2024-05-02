# # Create CloudWatch Event Rule for CloudTrail Security Group Events
# resource "aws_cloudwatch_event_rule" "cloudtrail_security_group_events" {
#   name         = var.security_group_event_name
#   description  = var.security_group_event_description
#   event_pattern = <<PATTERN
# {
#   "source": ["aws.cloudtrail"],
#   "detail-type": ["AWS API Call via CloudTrail"],
#   "detail": {
#     "eventSource": ["ec2.amazonaws.com"],
#     "eventName": ["AuthorizeSecurityGroupIngress", "AuthorizeSecurityGroupEgress", "RevokeSecurityGroupIngress", "RevokeSecurityGroupEgress"]
#   }
# }
# PATTERN
# }

# # Create CloudWatch Event Rule for AWS Config
# resource "aws_cloudwatch_event_rule" "config_rule_events" {
#   name                = var.config_rule_event_name
#   description         = var.config_rule_event_description
#   event_pattern       = <<PATTERN
# {
#   "source": ["aws.config"],
#   "detail-type": ["Config Rules Compliance Change"],
#   "detail": {
#     "configRuleName": ["*"]
#   }
# }
# PATTERN
# }

