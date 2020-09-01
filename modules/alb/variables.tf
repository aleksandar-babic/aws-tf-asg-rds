variable "env" {
  type        = string
  description = "Name of the environment resources are deployed to. (ex. my-super-project-dev)."
}

variable "subnets_to_use" {
  type        = list(string)
  description = "List of Subnet IDs to use in ALB."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to use in ALB."
}