terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.16.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}

locals {
    account_id    = data.aws_caller_identity.current.account_id
    environment = "Stage"
    team_name = "Infrastructure"
    service_name = "Blue"
}

locals {
    default_tags = {
        Environment = local.environment
        Team = local.team_name
        Service = local.service_name
    }
}

resource "aws_vpc" "this" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.instance_tenancy

  tags = local.default_tags
}

