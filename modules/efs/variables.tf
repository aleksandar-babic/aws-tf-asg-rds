variable "env" {
  type        = string
  description = "Name of the environment resources are deployed to. (ex. my-super-project-dev)."
}

variable "trusted_sgs" {
  type        = list(string)
  description = "List of the SGs that EFS will trust to."
}

variable "available_subnets" {
  type        = list(string)
  description = "List of Subnet IDs where EFS should be available"
}