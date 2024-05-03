terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.4.6"
    }
  }
  #required_version = ">= 0.13"
}

provider "aws" {
  region = var.aws_region

}
provider "aws" {
  region = "us-east-1"
  alias  = "useast1"
}