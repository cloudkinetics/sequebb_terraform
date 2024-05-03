# Input Variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "ap-southeast-1"
}
# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type        = string
  default     = "PROD"
}
# Business Division
variable "business_divsion" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type        = string
  default     = "SEQB"
}

# VPC Input Variables

# VPC Name
variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "myvpc"
}

# VPC CIDR Block
variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.0.0.0/16"
}

# VPC Availability Zones
variable "vpc_availability_zones" {
  description = "VPC Availability Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# VPC Public Subnets
variable "vpc_public_subnets" {
  description = "VPC Public Subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

# VPC Private Subnets
variable "vpc_private_subnets" {
  description = "VPC Private Subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# VPC Database Subnets
variable "vpc_database_subnets" {
  description = "VPC Database Subnets"
  type        = list(string)
  default     = ["10.0.151.0/24", "10.0.152.0/24"]
}

# VPC Create Database Subnet Group (True / False)
variable "vpc_create_database_subnet_group" {
  description = "VPC Create Database Subnet Group"
  type        = bool
  default     = true
}

# VPC Create Database Subnet Route Table (True or False)
variable "vpc_create_database_subnet_route_table" {
  description = "VPC Create Database Subnet Route Table"
  type        = bool
  default     = true
}


# VPC Enable NAT Gateway (True or False) 
variable "vpc_enable_nat_gateway" {
  description = "Enable NAT Gateways for Private Subnets Outbound Communication"
  type        = bool
  default     = true
}

# VPC Single NAT Gateway (True or False)
variable "vpc_single_nat_gateway" {
  description = "Enable only single NAT Gateway in one Availability Zone to save costs during our demos"
  type        = bool
  default     = true
}

variable "igw_name" {
  default = "A_STAR_IGW"

}
variable "natgw_name" {
  default = "A_STAR_NAT"

}
variable "public_subnet_names" {
  description = "Explicit values to use in the Name tag on public subnets. If empty, Name tags are generated"
  type        = list(string)
  default     = ["a1", "a2"]
}

variable "private_subnet_names" {
  description = "Explicit values to use in the Name tag on private subnets. If empty, Name tags are generated"
  type        = list(string)
  default     = ["a1", "a2"]
}
variable "database_subnet_names" {
  type    = list(string)
  default = ["db1", "db2"]
}

##################ec2@@@@@@@@@@

#EC2 Variables
variable "ec2_name" {
  type    = string
  default = "ec1"
}

variable "ami_id" {
  type    = string
  default = ""
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "availability_zone" {
  default = "ap-southeast-1a"
}
variable "key_name" {
  default = "A_STAR_UAT"
}
variable "tenacity" {
  default = "default"
}

variable "ec2_subnets" {
  type    = list(string)
  default = []
}

variable "iam_role_name" {
  default = "ssm"
}

variable "password_length" {

}
variable "engine_version" {

}
variable "identifier" {

}
variable "username" {

}
variable "skip_final_snapshot" {

}
variable "db_subnet_group_name" {

}
variable "instance_class" {

}
variable "allocated_storage" {
  default = "80"
}

variable "efs_name" {
  
}
variable "creation_token" {
  
}

variable "Domain_name" {
  type = string
}

# s3
variable "bucket_name" {
  
}
variable "acl_s3" {
  
}

#######################################a#####################################


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