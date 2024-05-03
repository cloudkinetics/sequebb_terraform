#common parameters
Environment = ""

#parameters for acm
common_name           = ""
organization          = ""
validity_period_hours = 12

#parameters for cloudtrail
cloudtrail_name = ""
s3_bucket_name_cloud_trail = ""

#parameters for cloudwatch rule
config_rule_name = ""
config_discription = ""
security_group_name = ""
security_group_description = ""
sns_topic_name = ""
subscription_endpoint = ""

# #parameters for cloudwatch
# cloudwatch_log_group_name = ["SecurityGroupChangesAlarm1", "1ConfigRuleComplianceChangesAlarm"]

# #parameters for cloudwatch event rule
# security_group_event_name        = "SecurityGroupChangesAlarm1"
# security_group_event_description = "SecurityGroupChangesAlarm1"
# config_rule_event_name           = "ConfigRuleComplianceChangesAlarm1"
# config_rule_event_description    = "ConfigRuleComplianceChangesAlarm1"

# #parameters for cloudwatch metric alarm
# alarm_name          = ["SecurityGroupChangesAlarm1", "ConfigRuleComplianceChangesAlarm1"]
# comparison_operator = ["GreaterThanThreshold", "GreaterThanThreshold"]
# evaluation_periods  = ["1", "1"]
# metric_name         = ["SecurityGroupChanges1", "ConfigRuleComplianceChanges1"]
# namespace           = ["AWS/EC21", "AWS/Config1"]
# period              = ["300", "300"]
# statistic           = ["Sum", "Sum"]
# threshold           = ["1", "1"]
# alarm_description   = ["Alarm when there are changes in Security Groups", "Alarm when there are changes in AWS Config rule compliance"]

#parameters for cloudwatch metric filter
# metric_filter_name              = ["SecurityGroupChangesAlarm", "ConfigRuleComplianceChanges"]
# pattern                         = ["{$.eventName = AuthorizeSecurityGroupIngress || $.eventName = AuthorizeSecurityGroupEgress || $.eventName = RevokeSecurityGroupIngress || $.eventName = RevokeSecurityGroupEgress}", "{$.eventName = ConfigRuleEvaluation*}"]
# metric_transformation_name      = ["SecurityGroupChanges", "ConfigRuleComplianceChanges"]
# metric_transformation_namespace = ["AWS/EC2", "AWS/Config"]
# metric_transformation_value     = [1, 1]

# #parameters for log subscription filter
# log_subscription_filter_name = ["CloudTrailSecurityGroupEventsLogSubscription1", "1AWSConfigRuleEventsLogSubscription"]

#parameters for config
# config_name         = "testconfig1112"
# config_channel_name = "test1"
# recorder_enable     = true

#parameters for config bucket
# config_policy_name          = "aws_config_polic1y"
# config_bucket               = "config-111log-test-bucket-1209219381"
# config_bucket_force_destroy = false #bool



#parameters for guardduty
enable_guardduty = true

#parameters for iam_role
config_role_name = ""


#parameters for iam_user
user_name       = ""
policy_arn      = ""

#parameters for kms
kms_description             = ""
kms_deletion_window_in_days = 10    #number
kms_multi_region            = false #bool




#parameters for ses
email_identity = ""

#parameters for sftp
# identity_provider_type = "SERVICE_MANAGED"
# endpoint_type = "PUBLIC"
# sftp_user_name = "sftp-user11"
# sftp_role_name = "aws_sftp_role11"
creation_token = ""
# subnet_id = "subnet-0cd4f723be77b1cb9"