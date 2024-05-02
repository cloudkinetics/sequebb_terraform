
module "acm" {
  source                = "./modules/acm"
  common_name           = var.common_name
  organization          = var.organization
  validity_period_hours = var.validity_period_hours
  Environment = var.Environment

}

module "cloudtrail" {
  source                        = "./modules/cloudtrail"
  cloudtrail_name = var.cloudtrail_name
  s3_bucket_name_cloud_trail = var.s3_bucket_name_cloud_trail


}

module "cloudwatch_rule" {
  source = "./modules/cloudwatch_rule"
  config_rule_name = var.config_rule_name
  config_discription = var.config_discription
  security_group_name = var.security_group_name
  security_group_description = var.security_group_description
  sns_topic_name = var.sns_topic_name
  subscription_endpoint = var.subscription_endpoint
}

# module "cloudwatch" {
#   source                    = "./modules/cloudwatch"
#   cloudwatch_log_group_name = var.cloudwatch_log_group_name
#   Environment = var.Environment
# }

# module "cloudwatch_event_rule" {
#   source                           = "./modules/cloudwatch_event_rule"
#   security_group_event_name        = var.security_group_event_name
#   security_group_event_description = var.security_group_event_description
#   config_rule_event_name           = var.config_rule_event_name
#   config_rule_event_description    = var.config_rule_event_description
# }

# module "cloudwatch_metric_alarm" {
#   source              = "./modules/cloudwatch_metric_alarm"
#   alarm_name          = var.alarm_name
#   comparison_operator = var.comparison_operator
#   evaluation_periods  = var.evaluation_periods
#   metric_name         = var.metric_name
#   namespace           = var.namespace
#   period              = var.period
#   statistic           = var.statistic
#   threshold           = var.threshold
#   alarm_description   = var.alarm_description
#   Environment         = var.Environment
#}

# module "cloudwatch_metric_filter" {
#   source                          = "./modules/cloudwatch_metric_filter"
#   metric_filter_name              = var.metric_filter_name
#   pattern                         = var.pattern
#   log_group_name                  = [module.cloudwatch.cloudwatch_name[0], module.cloudwatch.cloudwatch_name[1]]
#   metric_transformation_name      = var.metric_transformation_name
#   metric_transformation_namespace = var.metric_transformation_namespace
#   metric_transformation_value     = var.metric_transformation_value
# }


# module "log_subscription_filter" {
#   source                                  = "./modules/log_subscription_filter"
#   log_subscription_filter_name            = var.log_subscription_filter_name
#   log_subscription_group_name             = [module.cloudwatch.cloudwatch_name[0], module.cloudwatch.cloudwatch_name[1]]
#   log_subscription_filter_destination_arn = [module.cloudwatch.cloudwatch_arn[0], module.cloudwatch.cloudwatch_arn[1]]
# }

# module "config" {
#   source                = "./modules/config"
#   config_name           = var.config_role_name
#   config_role_arn       = module.iam_role.config_role_arn
#   config_channel_name   = var.config_channel_name
#   config_s3_bucket_name = module.config_bucket.config_bucket_name
#   recorder_enable       = var.recorder_enable
#   kms_key               = module.kms.key_arn
# }

# module "config_bucket" {
#   source                      = "./modules/config_bucket"
#   config_policy_name          = var.config_policy_name
#   config_role                 = module.iam_role.config_role_name
#   config_bucket               = var.config_bucket
#   config_bucket_force_destroy = var.config_bucket_force_destroy
# }

module "dns" {
  source = "./modules/dns"
}


module "guardduty" {
  source           = "./modules/guardduty"
  enable_guardduty = var.enable_guardduty
  Environment      = var.Environment

}

module "iam_role" {
  source           = "./modules/iam_role"
  config_role_name = var.config_role_name
  Environment      = var.Environment
}

module "iam_user" {
  source          = "./modules/iam_user"
  user_name       = var.user_name
  policy_arn      = var.policy_arn
  Environment     = var.Environment
}

module "kms" {
  source                      = "./modules/kms"
  kms_description             = var.kms_description
  kms_deletion_window_in_days = var.kms_deletion_window_in_days
  kms_multi_region            = var.kms_multi_region
  Environment                 = var.Environment
}



module "security_hub" {
  source                   = "./modules/security hub"
 
}

module "ses" {
  source         = "./modules/ses"
  email_identity = var.email_identity
}

module "sftp" {
  source                      = "./modules/sftp"
  creation_token = var.creation_token
  # subnet_id = var.subnet_id
  # sftp_user_name = var.sftp_user_name
  # sftp_rolename = var.sftp_role_name
  # environment = var.Environment
  # identity_provider_type = var.identity_provider_type
  # endpoint_type = var.endpoint_type
}

# data "aws_iam_role" "subnet" {#add subnet name here
#   name = ""
# }