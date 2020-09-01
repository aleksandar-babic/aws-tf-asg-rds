resource "aws_efs_file_system" "data" {
  creation_token   = "es-persistent-data"
  performance_mode = "generalPurpose"

  tags = {
    Name = var.env
  }
}

resource "aws_security_group" "efs" {
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = var.trusted_sgs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_efs_mount_target" "main" {
  count = length(var.available_subnets)

  file_system_id  = aws_efs_file_system.data.id
  subnet_id       = var.available_subnets[count.index]
  security_groups = [aws_security_group.efs.id]
}