output "app_dns_name" {
  description = "DNS Name of the App ALB."
  value       = module.alb.dns_name
}

output "app_url" {
  description = "URL of the App."
  value       = "http://${module.alb.dns_name}"
}