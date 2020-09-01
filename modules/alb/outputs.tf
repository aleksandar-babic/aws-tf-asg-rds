output "target_group_arns" {
  description = "List of TG ARNs from the ALB."
  value       = module.alb.target_group_arns
}

output "security_group_id" {
  description = "ID of the SG that ALB uses."
  value       = aws_security_group.elb.id
}

output "dns_name" {
  description = "DNS name of the load balancer."
  value       = module.alb.this_lb_dns_name
}