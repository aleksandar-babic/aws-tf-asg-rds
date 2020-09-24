resource "random_password" "db" {
  length  = var.db_password_length
  special = false
}

resource "aws_ssm_parameter" "db_password" {
  name  = "db_password-${var.env}"
  type  = "SecureString"
  value = random_password.db.result
}

resource "aws_security_group" "rds" {
  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = var.trusted_sgs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = var.env

  engine            = "mysql"
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  storage_encrypted = false

  name     = var.db_name
  username = var.db_username
  password = random_password.db.result
  port     = var.db_port

  vpc_security_group_ids = [aws_security_group.rds.id]
  subnet_ids             = var.available_subnets

  maintenance_window              = var.maintenance_window
  backup_window                   = var.backup_window
  multi_az                        = var.multi_az
  backup_retention_period         = var.backup_retention_period
  enabled_cloudwatch_logs_exports = ["audit", "general"]
  family                          = "mysql5.7"
  major_engine_version            = "5.7"
  final_snapshot_identifier       = var.env
  deletion_protection             = false

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8"
    },
    {
      name  = "character_set_server"
      value = "utf8"
    }
  ]
}