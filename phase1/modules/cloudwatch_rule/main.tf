resource "aws_cloudwatch_event_rule" "config" {
  name        = var.config_rule_name
  description = var.config_discription

  event_pattern = jsonencode({
  "source": ["aws.config"],
  "detail-type": ["AWS API Call via CloudTrail"],
  "detail": {
    "eventSource": ["config.amazonaws.com"],
    "eventName": ["PutConfigurationRecorder", "StopConfigurationRecorder", "DeleteDeliveryChannel", "PutDeliveryChannel"]
  }

  })
}

resource "aws_cloudwatch_event_rule" "security_group" {
  name        = var.security_group_name
  description = var.security_group_description

  event_pattern = jsonencode({
    "source": ["aws.ec2"],
    "detail-type": ["AWS API Call via CloudTrail"],
    "detail": {
      "eventSource": ["ec2.amazonaws.com"],
      "eventName": ["AuthorizeSecurityGroupIngress", "AuthorizeSecurityGroupEgress", "RevokeSecurityGroupIngress", "RevokeSecurityGroupEgress", "CreateSecurityGroup", "DeleteSecurityGroup"]
    }
  })
}

resource "aws_cloudwatch_event_target" "sns_security_group" {
  rule      = aws_cloudwatch_event_rule.security_group.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.aws_sns_topic.arn
}

resource "aws_cloudwatch_event_target" "sns_config" {
  rule      = aws_cloudwatch_event_rule.config.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.aws_sns_topic.arn
}

resource "aws_sns_topic" "aws_sns_topic" {
  name = var.sns_topic_name
}

resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.aws_sns_topic.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.aws_sns_topic.arn
  protocol  = "email"
  endpoint  = var.subscription_endpoint
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [aws_sns_topic.aws_sns_topic.arn]
  }
}