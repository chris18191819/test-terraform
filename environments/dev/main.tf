provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source           = "../../modules/vpc"
  environment      = var.environment
  vpc_cidr         = var.vpc_cidr
  azs              = var.azs
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  database_subnets = var.database_subnets
}

module "eks" {
  source            = "../../modules/eks"
  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  private_subnets   = module.vpc.private_subnets
  node_min_size     = var.node_min_size
  node_max_size     = var.node_max_size
  node_desired_size = var.node_desired_size
  instance_types    = var.instance_types
}

module "rds" {
  source                     = "../../modules/rds"
  environment                = var.environment
  db_instance_class          = var.db_instance_class
  db_allocated_storage       = var.db_allocated_storage
  database_subnet_group_name = module.vpc.database_subnet_group_name
  vpc_security_group_id      = module.vpc.default_security_group_id
}
