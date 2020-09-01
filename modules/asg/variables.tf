variable "env" {
  type        = string
  description = "Name of the environment resources are deployed to. (ex. my-super-project-dev)."
}

variable "min_size" {
  type        = number
  description = "Minimum size of the ASG."
}

variable "max_size" {
  type        = number
  description = "Maximum size of the ASG."
}
variable "desired_capacity" {
  type        = number
  description = "Desired capacity of the ASG."
}

variable "cpu_metric_period" {
  type        = string
  description = "CPUUtilization Auto scaling policy metric period in seconds."
}

variable "cpu_metric_up_threshold" {
  type        = string
  description = "CPUUtilization Auto scaling policy metric threshold to scale-up."
}

variable "cpu_metric_down_threshold" {
  type        = string
  description = "CPUUtilization Auto scaling policy metric threshold to scale-down."
}

variable "instance_type" {
  type        = string
  description = "Instance type of the ASG."
}

variable "elb_security_group_id" {
  type        = string
  description = "ID of the ELB security group."
}

variable "target_group_arns" {
  type        = list(string)
  description = "List of TG ARNs to use in ASG."
}

variable "subnets_to_use" {
  type        = list(string)
  description = "List of Subnet IDs to use in ASG."
}

variable "efs_mount_point" {
  type        = string
  description = "Mount point where EFS should be mounted in ASG instance."
}

variable "efs_dns_name" {
  type        = string
  description = "DNS name of EFS that will be used to mount in ASG instance."
}

variable "db_name" {
  type        = string
  description = "Name of the DB."
}

variable "db_username" {
  type        = string
  description = "Name of the DB user."
}

variable "db_ip" {
  type        = string
  description = "IP of the DB."
}

variable "ssm_db_password" {
  type        = string
  description = "Name of the SSM parameter with db password."
}

variable "ssm_region" {
  type        = string
  description = "Name of the region where SSM parameters are defined."
}