# Generic Variables
aws_region       = "ap-southeast-1"
environment      = "STG"
business_divsion = "SEQB"

# VPC Variables
vpc_name                               = "SQB-PROD-VPC"
vpc_cidr_block                         = "10.1.0.0/16"
vpc_availability_zones                 = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
vpc_public_subnets                     = ["10.1.0.0/21", "10.1.8.0/21"]
vpc_private_subnets                    = ["10.1.16.0/21", "10.1.24.0/21", "10.1.32.0/21"]
vpc_database_subnets                   = ["10.1.40.0/21", "10.1.48.0/21"]
vpc_create_database_subnet_group       = true
vpc_create_database_subnet_route_table = true
vpc_enable_nat_gateway                 = true
vpc_single_nat_gateway                 = true

public_subnet_names   = ["SQB-PROD-pub-az1", "SQB-PROD-pub-az2"]
private_subnet_names  = ["SQB-PROD-pri-app-az1", "SQB-PROD-pri-app-az2", "SQB-PROD-pri-app-az3"]
database_subnet_names = ["SQB-PROD-pri-db-az1", "SQB-PROD-pri-db-az2"]
igw_name              = "SQB_PROD_IGW"
natgw_name            = "SQB_PROD_NAT"

#ec2 bastion
ec2_name          = "SQB-BastionHost-PROD"
ami_id            = "ami-0a3ff097090be9c13"
instance_type     = "t3.medium"
availability_zone = "ap-southeast-1a"
iam_role_name     = "ssm"
key_name          = "Sqb-stagging"

# parameters for password

password_length = "12"

#parrameters for rds

engine_version       = "8.0.35"
identifier           = "sqb-prod-db-rds" #only lowercase allowed
username             = "prodadmin"
skip_final_snapshot  = true
db_subnet_group_name = "sqb-prod-db-sub-group"
instance_class       = "db.m6g.2xlarge"
allocated_storage    = "200"

# parameters for efs

#efs_name       = "SQB-PROD-EFS"
#creation_token = "PROD-token"

#Domain_name = "*.example.com"

#parameters for s3
#bucket_name = "sqeb-staging-bucket"
#acl_s3      = "private"


############################################a#########################################


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
