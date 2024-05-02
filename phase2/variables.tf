#comman vaeiables
variable "Environment" {
  
}

#variables for acm
variable "common_name" {

}
variable "organization" {

}
variable "validity_period_hours" {

}


#variable for cloudtrail
variable "cloudtrail_name" {
  
}

variable "s3_bucket_name_cloud_trail" {
  
}


# #variables for cloudwatch
# variable "cloudwatch_log_group_name" {
#   type = list(string)
# }

# #variables for cloudwatch event rule
# variable "security_group_event_name" {

# }
# variable "security_group_event_description" {

# }
# variable "config_rule_event_name" {

# }
# variable "config_rule_event_description" {

# }

# #variables for cloudwatch metric alarm
# variable "alarm_name" {
#   type = list(string)
# }
# variable "comparison_operator" {
#   type = list(string)

# }
# variable "evaluation_periods" {
#   type = list(string)
# }
# variable "metric_name" {
#   type = list(string)
# }
# variable "namespace" {
#   type = list(string)
# }
# variable "period" {
#   type = list(string)
# }
# variable "statistic" {
#   type = list(string)
# }
# variable "threshold" {
#   type = list(string)
# }
# variable "alarm_description" {
#   type = list(string)
# }

#variables for cloudwatch metric filter
# variable "metric_filter_name" {
#   type = list(string)
# }
# variable "pattern" {
#   type = list(string)
# }
# variable "metric_transformation_name" {
#   type = list(string)
# }
# variable "metric_transformation_namespace" {
#   type = list(string)
# }
# variable "metric_transformation_value" {
#   type = list(string)
# }

#variables for cloudwatch rule
variable "config_rule_name" {
  
}
variable "config_discription" {
  
}
variable "security_group_name" {
  
}
variable "security_group_description" {
  
}
variable "sns_topic_name" {
  
}
variable "subscription_endpoint" {
  
}

# #variables for config
# variable "config_name" {

# }

# variable "config_channel_name" {

# }

# variable "recorder_enable" {

# }

#variables for config bucket
# variable "config_policy_name" {

# }
# variable "config_bucket" {

# }
# variable "config_bucket_force_destroy" {
#   type = bool
# }



#variables for guardduty
variable "enable_guardduty" {

}

#variables for iam_role 
variable "config_role_name" {

}



#variables for iam_user
variable "user_name" {

}
variable "policy_arn" {

}

#variables for kms
variable "kms_description" {

}
variable "kms_deletion_window_in_days" {
  type = number
}
variable "kms_multi_region" {
  type = bool
}

# #variables for log subscription filter

# variable "log_subscription_filter_name" {
#   type = list(string)
# }


variable "email_identity" {
  
}
#variables for ses
variable "creation_token" {
  
}

# variable "subnet_id" {
  
# }

# variable "sftp_user_name" {
  
# }

# variable "sftp_role_name" {
  
# }

# variable "identity_provider_type" {
  
# }

# variable "endpoint_type" {
  
# }