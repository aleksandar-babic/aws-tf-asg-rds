output "asg_security_group_id" {
  description = "ID of the security group used in ASG."
  value       = aws_security_group.asg.id
}