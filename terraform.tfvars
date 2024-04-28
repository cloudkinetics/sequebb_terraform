# Generic Variables
aws_region       = "ap-southeast-1"
environment      = "STG"
business_divsion = "SEQB"

# VPC Variables
vpc_name                               = "SEQB-STG-VPC"
vpc_cidr_block                         = "10.0.0.0/16"
vpc_availability_zones                 = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
vpc_public_subnets                     = ["10.0.0.0/21", "10.0.8.0/21"]
vpc_private_subnets                    = ["10.0.16.0/21", "10.0.24.0/21", "10.0.32.0/21"]
vpc_database_subnets                   = ["10.0.40.0/21", "10.0.48.0/21"]
vpc_create_database_subnet_group       = true
vpc_create_database_subnet_route_table = true
vpc_enable_nat_gateway                 = true
vpc_single_nat_gateway                 = true

public_subnet_names   = ["SQB-STAGING-pub-az1", "SQB-STAGING-pub-az2"]
private_subnet_names  = ["SQB-STAGING-pri-app-az1", "SQB-STAGING-pri-app-az2", "SQB-STAGING-pri-app-az3"]
database_subnet_names = ["SQB-STAGING-pri-db-az1", "SQB-STAGING-pri-db-az2"]
igw_name              = "SEQB_STG_IGW"
natgw_name            = "SEQB_STG_NAT"

#ec2 bastion
ec2_name          = "SQB-BastionHost-STAGING"
ami_id            = "ami-0a3ff097090be9c13"
instance_type     = "t3.medium"
availability_zone = "ap-southeast-1a"
iam_role_name     = "ssm"
key_name          = "A_STAR"

# parameters for password

password_length = "12"

#parrameters for rds

engine_version       = "8.0.35"
identifier           = "sqb-staging-db-rds" #only lowercase allowed
username             = "prodadmin"
skip_final_snapshot  = true
db_subnet_group_name = "sqec-stg-db-sub-group"
instance_class       = "db.m6g.xlarge"
allocated_storage    = "128"

# parameters for efs

efs_name       = "seqb-stg-efs"
creation_token = "STG-token"

Domain_name = "*.example.com"

#parameters for s3
bucket_name = "sqeb-stg-bucket"
acl_s3      = "private"



