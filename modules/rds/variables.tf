variable "env" {
  type        = string
  description = "Name of the environment resources are deployed to. (ex. my-super-project-dev)."
}

variable "available_subnets" {
  type        = list(string)
  description = "List of Subnet IDs where RDS should be available."
}

variable "trusted_sgs" {
  type        = list(string)
  description = "List of the SGs that RDS will trust to."
}

# All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
variable "engine_version" {
  type        = string
  description = "Version of the MySQL engine to use."
}

variable "instance_class" {
  type        = string
  description = "Instance class used for the RDS."
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes."
  type        = string
  default     = "30"
}

variable "db_name" {
  description = "The DB name to create."
  type        = string
}

variable "db_username" {
  description = "Username for the master DB user."
  type        = string
}

variable "db_password_length" {
  description = "Lenght of the random password that will be generated for the DB."
  type        = number
  default     = 24
}

variable "db_port" {
  description = "The port on which the DB accepts connections."
  type        = string
  default     = "3306"
}

# disable backups to create DB faster
variable "backup_retention_period" {
  description = "The days to retain backups for."
  type        = number
  default     = 1
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ."
  type        = bool
  default     = false
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'."
  type        = string
  default     = "Mon:00:00-Mon:03:00"
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window."
  type        = string
  default     = "03:10-05:10"
}