module "vpc" {
  source = "./modules/vpc"

  # VPC Basic Details
  name                  = var.vpc_name
  cidr                  = var.vpc_cidr_block
  azs                   = var.vpc_availability_zones
  public_subnets        = var.vpc_public_subnets
  private_subnets       = var.vpc_private_subnets
  public_subnet_names   = var.public_subnet_names
  private_subnet_names  = var.private_subnet_names
  database_subnet_names = var.database_subnet_names

  # Database Subnets
  database_subnets                   = var.vpc_database_subnets
  create_database_subnet_group       = var.vpc_create_database_subnet_group
  create_database_subnet_route_table = var.vpc_create_database_subnet_route_table
  # create_database_internet_gateway_route = true
  create_database_nat_gateway_route = true

  manage_default_security_group = false

  # Cloudwatch log group and IAM role will be created
  enable_flow_log                           = true
  create_flow_log_cloudwatch_log_group      = true
  create_flow_log_cloudwatch_iam_role       = true
  flow_log_max_aggregation_interval         = 60
  flow_log_cloudwatch_log_group_name_prefix = "/aws/seqb-prod-vpc-flow-logz/"
  flow_log_cloudwatch_log_group_name_suffix = "SEQB"
  flow_log_cloudwatch_log_group_class       = "INFREQUENT_ACCESS"

  vpc_flow_log_tags = local.tags

  # NAT Gateways - Outbound Communication
  enable_nat_gateway = var.vpc_enable_nat_gateway
  single_nat_gateway = var.vpc_single_nat_gateway

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = local.tags
  vpc_tags             = local.tags

  # Additional Tags to Subnets
  public_subnet_tags = {
    Type = "Public Subnets"
  }
  private_subnet_tags = {
    Type = "Private Subnets"
  }
  database_subnet_tags = {
    Type = "Private Database Subnets"
  }
  igw_tags = {
    Name = "${var.igw_name}"
  }
  nat_gateway_tags = {
    Name = "${var.natgw_name}"
  }

}

module "alb_sg" {
  source              = "./modules/sg"
  name                = "SQB-STAGING-alb-sg"
  description         = "Security group with HTTP & HTTPS, egress ports are all world open"
  vpc_id              = module.vpc.vpc_id
  ingress_rules       = ["https-443-tcp", "http-80-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
  tags                = local.tags
}

module "app_sg" { 
  source      = "./modules/sg"
  name        = "SQB-STAGING-app-sg"
  description = "Security group with HTTP & HTTPS and custom rule, egress ports are all world open"
  vpc_id      = module.vpc.vpc_id

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.alb_sg.security_group_id
    },
    {
      rule                     = "https-443-tcp"
      source_security_group_id = module.alb_sg.security_group_id
    },    
    # {
    #   rule                     = "nfs-tcp"
    #   source_security_group_id = module.alb_sg.security_group_id
    # }
  ]
  number_of_computed_ingress_with_source_security_group_id = 2
  ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = "10.0.0.0/16"
    },
    {
      rule        = "nfs-tcp"
      cidr_blocks = "10.0.0.0/16"
    }

  ]


  egress_rules       = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]
  tags               = local.tags
}

module "db_sg" {
  source      = "./modules/sg"
  name        = "SQB-STAGING-db-sg"
  description = "Security group with mssql and custom rule, egress ports are all world open"
  vpc_id      = module.vpc.vpc_id

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = module.alb_sg.security_group_id
    },
    {
      rule                     = "mysql-tcp"
      source_security_group_id = module.app_sg.security_group_id ###web_sg
    },
    {
      from_port                = 12345
      to_port                  = 12345
      protocol                 = 6
      description              = "Custom MySQL Service name"
      source_security_group_id = module.app_sg.security_group_id
    }

  ]
  number_of_computed_ingress_with_source_security_group_id = 3

  egress_rules       = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]
  tags               = local.tags
}

module "bastion_sg" {
  source      = "./modules/sg"
  description = "JUMPHOST-STG-SG"
  name        = "JUMPHOST-STG-SG"
  vpc_id      = module.vpc.vpc_id
  # Ingress Rules & CIDR Block  
  ingress_rules       = ["rdp-tcp","rdp-udp"] 
  ingress_cidr_blocks = ["0.0.0.0/0"]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags         = local.tags
}

module "ec2" {
  source        = "./modules/ec2"
  name          = var.ec2_name
  ami           = var.ami_id
  instance_type = var.instance_type

  key_name                    = var.key_name
  availability_zone           = var.availability_zone
  tenancy                     = var.tenacity
  associate_public_ip_address = true
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [module.bastion_sg.security_group_id] #module.vpc.default_security_group_id,
  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_name               = var.iam_role_name
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  user_data = local.win_user_data
  #user_data_base64            = base64encode(local.user_data)
  user_data_replace_on_change = true

  tags       = local.tags
  monitoring = true
}

module "ec2_appserver" {
  source = "./modules/ec2"

  name = "SQB-STAGING-web-app" ###

  ami                         = "ami-09b1e8fc6368b8a3a" ###
  instance_type               = "t3.2xlarge"  ###
  availability_zone           = var.availability_zone
  subnet_id                   = element(module.vpc.private_subnets, 0)
  vpc_security_group_ids      = [module.app_sg.security_group_id]
  associate_public_ip_address = false
  key_name                    = var.key_name
  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
  enable_volume_tags = false
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      #      throughput  = 200
      volume_size = 30
      tags = {
        Name = "my-root-block"
      }
    }
  ]

  ebs_block_device = [
    {
      device_name = "/dev/sdf"
      volume_type = "gp3"
      volume_size = 128
      tags = {
        MountPoint = "/mnt/data"
      }
    }
  ]
  # enclave_options_enabled = true
  user_data = local.user_data
  #user_data_base64            = base64encode(local.user_data)
  user_data_replace_on_change = true

  tags = local.tags
}

module "password" {
  source          = "./modules/password"
  password_length = var.password_length

}

module "rds" {
  source                 = "./modules/rds"
  allocated_storage      = var.allocated_storage
  instance_class         = var.instance_class
  engine_version         = var.engine_version
  identifier             = var.identifier
  vpc_security_group_ids = [module.db_sg.security_group_id]
  username               = var.username
  password               = module.password.password
  skip_final_snapshot    = var.skip_final_snapshot
  Environment            = var.environment
  db_subnet_group_name   = var.db_subnet_group_name
  subnet_ids             = [module.vpc.database_subnets[0], module.vpc.database_subnets[1]]

}

module "efs" {
  source         = "./modules/EFS"
  creation_token = var.creation_token
  efs_name       = var.efs_name
  Environment    = var.environment

}

module "certificate" {
  source      = "./modules/ACMcertificate"
  common_name = var.Domain_name
  
}

module "alb" {
  source = "./modules/alb"
  name    = "SQB-STAGING-alb"
  vpc_id  = module.vpc.vpc_id
  internal = false
  load_balancer_type = "application"
  subnets = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]
  # Security Group
  security_groups = [module.alb_sg.security_group_id]


  #add a bucket name here for alb logging
  # access_logs = {
  #   bucket = "my-alb-logs"
  # }


  target_groups = {
    HTTP = {
      name                              = "HTTP-TG"
      protocol                          = "HTTP"#
      port                              = 80
      certificate_arn = module.certificate.certificate_arn
      target_type                       = "instance"
      load_balancing_cross_zone_enabled = true
      ip_address_type                   = "ipv4"
      load_balancer_arn                 = module.alb.arn
      target_id                         = "" ###update
      protocol_version = "HTTP1"

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/data/www/devt/public_html/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }

      create_attachment = false
    },

    sit-staging={
      name                              = "sit-staging"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 5
      load_balancing_cross_zone_enabled = true
      ip_address_type                   = "ipv4"
      load_balancer_arn                 = module.alb_pub.arn
      target_id                         = "" #add instanceid

      protocol_version = "HTTP1"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/data/www/devt/public_html/index.html"
        port                = "traffic-port"
        healthy_threshold   = 5
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200-399"
      }

      create_attachment = false

    },
    dev-staging = {
      name                              = "dev-staging"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 5
      load_balancing_cross_zone_enabled = true
      ip_address_type                   = "ipv4"
      load_balancer_arn                 = module.alb_pub.arn
      target_id                         = "" #add instanceid

      protocol_version = "HTTP1"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/data/www/devt/public_html/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }

      create_attachment = false

    },
    uat-staging = {
      name                              = "uat-staging"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 5
      load_balancing_cross_zone_enabled = true
      ip_address_type                   = "ipv4"
      load_balancer_arn                 = module.alb_pub.arn
      target_id                         = "" #add instanceid

      protocol_version = "HTTP1"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/data/www/devt/public_html/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }

      create_attachment = false

    }

  }

  listeners = {
    seqb-http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    },
    seqb-https = {
      port            = 443
      protocol        = "HTTPS"
      load_balancer_arn = module.alb.arn
      certificate_arn = module.certificate.certificate_arn #or other arn
      #ssl_policy = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
      forward = {
        target_group_key = "dev-staging"
        target_group_arn = module.alb.target_groups["dev-staging"].arn
      }
      rules = {

        devt-digitalqab-com = {

          priority = 1
          tags = {
            Name = "devt.digitalqab.com"
          }
          actions = [{
            type             = "forward"
            target_group_arn = module.alb.target_groups["dev-staging"].arn
            forward = {
              target_group = [
                {
                  arn    = module.alb.target_groups["dev-staging"].arn
                  weight = 1
                }
              ]
              stickiness = {
                duration = 3600
                enabled  = false
              }
            }
          }]
          conditions = [{
            host_header = {
              values = ["devt.digitalqab.com"]
            }
          }]
        },      

        sit-digitalqab-com= {

          priority = 2
          tags = {
            Name = "sit.digitalqab.com"
          }
          actions = [{
            type             = "forward"
            target_group_arn = module.alb.target_groups["sit-staging"].arn
            forward = {
              target_group = [
                {
                  arn    = module.alb.target_groups["sit-staging"].arn
                  weight = 1
                }
              ]
              stickiness = {
                duration = 3600
                enabled  = false
              }
            }
          }]
          conditions = [{
            host_header = {
              values = ["sit.digitalqab.com"]
            }
          }]
        },      

        uat-digitalqab-com= {

          priority = 3
          tags = {
            Name = "uat.digitalqab.com"
          }
          actions = [{
            type             = "forward"
            target_group_arn = module.alb.target_groups["uat-staging"].arn
            forward = {
              target_group = [
                {
                  arn    = module.alb.target_groups["uat-staging"].arn
                  weight = 1
                }
              ]
              stickiness = {
                duration = 3600
                enabled  = false
              }
            }
          }]
          conditions = [{
            host_header = {
              values = ["uat.digitalqab.com"]
            }
          }]
        }

      }
    }
  }

  tags = local.tags
}

module "waf" {
  providers = {
    aws = aws.useast1 #aws.aliasname
  }
  source     = "./modules/waf"
  region     = "us-east-1" #var.aws_region

} 

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
  acl_s3      = var.acl_s3
  Environment = var.environment
}

module "cdn" {
  source = "./modules/cloudfront"

  #aliases = ["cdn.example.com"]

  comment             = "My awesome CloudFront"
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  retain_on_delete    = false
  wait_for_deployment = false

  create_origin_access_identity = true
  origin_access_identities = {
    s3_bucket_one = "My awesome CloudFront can access"
  }

  logging_config = {
    bucket =  "sqeb-staging-bucket.s3.amazonaws.com"
  }

  origin = {
    something = {
      domain_name = "sqeb-staging-bucket.cloudfront.net"
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "match-viewer"
        origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      }
    }

    s3_one = {
      domain_name = "sqeb-staging-bucket.s3.amazonaws.com"
      s3_origin_config = {
        origin_access_identity = "s3_bucket_one"
      }
    }
  }

  default_cache_behavior = {
    target_origin_id           = "something"
    viewer_protocol_policy     = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
  }

  ordered_cache_behavior = [
    {
      path_pattern           = "/static/*"
      target_origin_id       = "s3_one"
      viewer_protocol_policy = "redirect-to-https"

      allowed_methods = ["GET", "HEAD", "OPTIONS"]
      cached_methods  = ["GET", "HEAD"]
      compress        = true
      query_string    = true
    }
  ]

  # viewer_certificate = {
  #   acm_certificate_arn = "arn:aws:acm:us-east-1:637423195989:certificate/272555cd-2cd0-443e-8f73-45bf62f90934"
  #   ssl_support_method  = "sni-only"
  # }
}

module "network_firewall" {
  source = "./modules/networkfirewall"

  # Firewall
  name        = "seqb-net-firewall"
  description = "Example network firewall"

  vpc_id = module.vpc.vpc_id
  subnet_mapping = {
    subnet1 = {
      subnet_id       = module.vpc.public_subnets[0]
      ip_address_type = "IPV4"
    }
    subnet2 = {
      subnet_id       = module.vpc.public_subnets[1]
      ip_address_type = "IPV4"
    }
  }

  # Logging configuration
  create_logging_configuration = false
  logging_configuration_destination_config = [
    {
      log_destination = {
        logGroup = "/aws/network-firewall/seqb"
      }
      log_destination_type = "CloudWatchLogs"
      log_type             = "ALERT"
    },
    {
      log_destination = {
        bucketName = "sqeb-stg-bucket"
        prefix     = "seqb"
      }
      log_destination_type = "S3"
      log_type             = "FLOW"
    }
  ]

  # Policy
  policy_name        = "sqeb-stg"
  policy_description = "Example network firewall policy"

  # policy_stateful_rule_group_reference = {
  #   one = {
  #     priority     = 0
  #     resource_arn = "arn:aws:network-firewall:us-east-1:1234567890:stateful-rulegroup/example"
  #   }
  # }

  policy_stateless_default_actions          = ["aws:pass"]
  policy_stateless_fragment_default_actions = ["aws:drop"]
  # policy_stateless_rule_group_reference = {
  #   one = {
  #     priority     = 0
  #     resource_arn = "arn:aws:network-firewall:us-east-1:1234567890:stateless-rulegroup/example"
  #   }
  # }

  tags = {
    Terraform   = "true"
    Environment = "staging"
  }
}

############################a#########################



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
