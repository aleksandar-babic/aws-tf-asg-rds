output "dns_name" {
  description = "DNS name of the EFS file system."
  value       = aws_efs_file_system.data.dns_name
}