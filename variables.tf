variable "env" {
  type        = string
  description = "Name of the environment resources are deployed to. (ex. my-super-project-dev)"
}

variable "region" {
  type        = string
  description = "Region where AWS provider will be initialized."
  default     = "eu-west-1"
}

variable "subnets_to_use" {
  type        = list(string)
  description = "List of default subnets to use."
  default     = ["a", "b", "c"]
}

variable "asg_min_size" {
  type        = number
  description = "Minimum size of the ASG."
  default     = 1
}

variable "asg_max_size" {
  type        = number
  description = "Maximum size of the ASG."
  default     = 5
}

variable "asg_desired_capacity" {
  type        = number
  description = "Desired capacity of the ASG."
  default     = 1
}

variable "asg_instance_type" {
  type        = string
  description = "Instance type of the ASG."
  default     = "t3.micro"
}

variable "asg_cpu_metric_period" {
  type        = string
  description = "CPUUtilization Auto scaling policy metric period in seconds."
  default     = "60"
}

variable "asg_cpu_metric_up_threshold" {
  type        = string
  description = "CPUUtilization Auto scaling policy metric threshold to scale-up."
  default     = "40"
}

variable "asg_cpu_metric_down_threshold" {
  type        = string
  description = "CPUUtilization Auto scaling policy metric threshold to scale-down."
  default     = "10"
}

# All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
variable "db_engine_version" {
  type        = string
  description = "Version of the MySQL engine to use."
  default     = "5.7.30"
}

variable "db_username" {
  description = "Username for the master DB user."
  type        = string
  default     = "dbuser"
}

variable "db_name" {
  description = "The DB name to create."
  type        = string
}

variable "db_instance_class" {
  type        = string
  description = "Instance class used for the RDS."
  default     = "db.m3.medium"
}