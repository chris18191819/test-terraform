module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.0"

  identifier = "${var.environment}-db"

  engine               = "postgres"
  engine_version       = "16"
  family               = "postgres16"
  major_engine_version = "16"
  instance_class       = var.db_instance_class

  allocated_storage = var.db_allocated_storage
  
  db_name  = "appdb"
  username = "dbadmin"
  port     = 5432

  # The gate's findings: monitoring, Multi-AZ, IAM auth, deletion
  # protection and performance insights.
  monitoring_interval                = 60
  multi_az                           = true
  iam_database_authentication_enabled = true
  deletion_protection                = true
  performance_insights_enabled       = true
  
  manage_master_user_password = true

  db_subnet_group_name   = var.database_subnet_group_name
  vpc_security_group_ids = [var.vpc_security_group_id]

  skip_final_snapshot = var.environment != "prod"

  tags = {
    Environment = var.environment
  }
}
