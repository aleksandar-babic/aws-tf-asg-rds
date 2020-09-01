data "aws_ssm_parameter" "al2-ecs-ami-id" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_security_group" "asg" {
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.elb_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_role" "asg" {
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.trust_ec2.json
}

data "aws_iam_policy_document" "trust_ec2" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "AmazonSSMManagedInstanceCore" {
  role       = aws_iam_role.asg.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "CloudWatchAgentServerPolicy" {
  role       = aws_iam_role.asg.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role_policy" "ec2_base" {
  name = "AllowBase"
  role = aws_iam_role.asg.name

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "logs:*",
          "kms:*"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
  EOF
}

resource "aws_iam_instance_profile" "asg" {
  path = "/"
  role = aws_iam_role.asg.name
}


module "asg" {
  source = "terraform-aws-modules/autoscaling/aws"

  name = var.env

  lc_name              = var.env
  image_id             = data.aws_ssm_parameter.al2-ecs-ami-id.value
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.asg.name
  user_data = templatefile("${path.module}/tpl/user-data.tpl", {
    mount_point     = var.efs_mount_point
    dns_name        = var.efs_dns_name
    db_name         = var.db_name
    db_username     = var.db_username
    db_ip           = var.db_ip
    ssm_db_password = var.ssm_db_password
    ssm_region      = var.ssm_region
  })
  security_groups   = [aws_security_group.asg.id]
  target_group_arns = var.target_group_arns

  root_block_device = [
    {
      volume_size = "30"
      volume_type = "gp2"
    },
  ]

  # Auto scaling group
  asg_name                  = var.env
  vpc_zone_identifier       = var.subnets_to_use
  health_check_type         = "ELB"
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  wait_for_capacity_timeout = 0
}


resource "aws_autoscaling_policy" "up" {
  name                   = "up_${var.env}"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 10
  autoscaling_group_name = module.asg.this_autoscaling_group_name
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm_up" {
  alarm_name          = "cpu_alarm_up_${var.env}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.cpu_metric_period
  statistic           = "Average"
  threshold           = var.cpu_metric_up_threshold

  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.up.arn]
}


resource "aws_autoscaling_policy" "down" {
  name                   = "down_${var.env}"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 10
  autoscaling_group_name = module.asg.this_autoscaling_group_name
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm_down" {
  alarm_name          = "cpu_alarm_down_${var.env}"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.cpu_metric_period
  statistic           = "Average"
  threshold           = var.cpu_metric_down_threshold

  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.down.arn]
}