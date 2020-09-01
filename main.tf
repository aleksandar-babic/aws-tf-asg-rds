resource "aws_default_vpc" "main" {}

resource "aws_default_subnet" "main" {
  for_each = toset(var.subnets_to_use)

  availability_zone = "${var.region}${each.value}"
}

module "alb" {
  source = "./modules/alb"

  env            = var.env
  subnets_to_use = [for s in aws_default_subnet.main : s.id]
  vpc_id         = aws_default_vpc.main.id
}

module "asg" {
  source = "./modules/asg"

  efs_dns_name              = module.efs.dns_name
  efs_mount_point           = "/var/www/html"
  env                       = var.env
  min_size                  = var.asg_min_size
  max_size                  = var.asg_max_size
  desired_capacity          = var.asg_desired_capacity
  instance_type             = var.asg_instance_type
  subnets_to_use            = [for s in aws_default_subnet.main : s.id]
  elb_security_group_id     = module.alb.security_group_id
  target_group_arns         = module.alb.target_group_arns
  db_name                   = var.db_name
  db_username               = var.db_username
  db_ip                     = module.rds.db_ip
  ssm_db_password           = module.rds.ssm_db_password
  ssm_region                = var.region
  cpu_metric_down_threshold = var.asg_cpu_metric_down_threshold
  cpu_metric_period         = var.asg_cpu_metric_period
  cpu_metric_up_threshold   = var.asg_cpu_metric_up_threshold
}

module "efs" {
  source = "./modules/efs"

  available_subnets = [for s in aws_default_subnet.main : s.id]
  env               = var.env
  trusted_sgs       = [module.asg.asg_security_group_id]
}

module "rds" {
  source = "./modules/rds"

  available_subnets = [for s in aws_default_subnet.main : s.id]
  db_name           = var.db_name
  db_username       = var.db_username
  engine_version    = var.db_engine_version
  env               = var.env
  instance_class    = var.db_instance_class
  trusted_sgs       = [module.asg.asg_security_group_id]
}