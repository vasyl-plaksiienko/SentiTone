variable "environment_name" {
  description = "Environment name i.e. dev, stg, prod"
  type = string
}

variable "aws_region" {
  description = "AWS region to deploy resources to"
  type        = string
  default     = "eu-west-1"
}

variable "main_bucket" {
  type = string
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Project = "SentiTone"
    ManagedBy = "Terraform"
  }
}

# Database module variables (passed through)
variable "db_username" {
  type = string
  default = "postgres"
}
variable "db_password" {
  type = string
  sensitive = true
}
variable "db_instance_class" {
  type = string
  default = "db.t4g.micro"
}
variable "db_engine" {
  type = string
  default = "postgres"
}
variable "db_engine_version" {
  type = string
  default = "16"
}
variable "db_allocated_storage" {
  type = number
  default = 20
}
variable "db_availability_zone" {
  type = string
  default = "eu-west-1c"
}

# EKS module variables (passed through)
#variable "eks_subnet_ids" { type = list(string), default = [] }
#variable "eks_node_group_desired_size" { type = number, default = 2 }
#variable "eks_node_group_min_size" { type = number, default = 1 }
#variable "eks_node_group_max_size" { type = number, default = 3 }
#variable "eks_node_instance_types" { type = list(string), default = ["t3.medium"] }
#variable "eks_availability_zones" { type = list(string), default = [] }