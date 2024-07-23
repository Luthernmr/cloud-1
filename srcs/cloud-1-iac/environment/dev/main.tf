terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }

  # Use AWS S3 to synchronize terraform state
  backend "s3" {
    bucket  = "42-cloud-1-terraform-state"
    key     = "state/terraform.tfstate"
    region  = "eu-west-3" # Paris
    encrypt = true

    # This Database has a `LockID` entry to prevent concurent access
    dynamodb_table = "42-cloud-1-terraform-state-lock"
  }
}

provider "aws" {
  # Use localy stored credentials (ex: .aws/credentials)
  profile = "default"

  # Those are provided by the profile
  # region     = var.provider_region
  # access_key = var.access_key
  # secret_key = var.secret_key
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

module "vpc" {
  source = "../../modules/vpc"
}

module "records" {
  source               = "../../modules/records/"
  domain_name          = var.domain_name
  wordpress_subdomain  = var.wordpress_subdomain
  phpmyadmin_subdomain = var.phpmyadmin_subdomain
  env_list             = var.env_list
  cloudflare_zone_id   = var.cloudflare_zone_id
  alb_dns_name         = module.alb.alb_dns_name
}

module "ec2" {
  source = "../../modules/ec2/"

  instance_type       = var.instance_type
  vpc_id              = module.vpc.vpc_id
  ft_wp_db            = module.rds.ft_wp_db
  domain_name         = var.domain_name
  wordpress_subdomain = var.wordpress_subdomain
  env_list            = var.env_list
  db_endpoint         = module.rds.rds_endpoints
  db_name             = module.rds.db_instance_name
  db_user             = var.db_user
  db_password         = var.db_password
  env                 = var.env
  efs_dns_name        = module.efs.efs_dns_name
}

module "alb" {
  source               = "../../modules/alb/"
  domain_name          = var.domain_name
  wordpress_subdomain  = var.wordpress_subdomain
  phpmyadmin_subdomain = var.phpmyadmin_subdomain
  lt_ids               = module.ec2.lt_ids
  env_list             = var.env_list
  vpc_id               = module.vpc.vpc_id
  public_subnet_id     = module.vpc.public_subnet_id
  public_subnet2_id    = module.vpc.public_subnet2_id
}

module "rds" {
  source      = "../../modules/rds/"
  db_name     = var.db_name
  db_user     = var.db_user
  db_password = var.db_password
  env_list    = var.env_list
}

module "efs" {
  source                    = "../../modules/efs"
  public_subnet_id          = module.vpc.public_subnet_id
  vpc_id                    = module.vpc.vpc_id
  ft_apps_security_group_id = module.ec2.ft_apps_security_group_id
}
