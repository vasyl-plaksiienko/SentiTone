variable "aws_region" {
  description = "AWS region to deploy resources to"
  type        = string
  default     = "us-east-1"
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
variable "db_name" { type = string, default = "sentitone" }
variable "db_username" { type = string, default = "app_user" }
variable "db_password" { type = string, sensitive = true }
variable "db_instance_class" { type = string, default = "db.t4g.micro" }
variable "db_engine" { type = string, default = "postgres" }
variable "db_engine_version" { type = string, default = "16" }
variable "db_allocated_storage" { type = number, default = 20 }
variable "db_subnet_ids" { type = list(string), default = [] }
variable "db_vpc_security_group_ids" { type = list(string), default = [] }

# EKS module variables (passed through)
variable "eks_cluster_name" { type = string, default = "sentitone-eks" }
variable "eks_version" { type = string, default = "1.30" }
variable "eks_subnet_ids" { type = list(string), default = [] }
variable "eks_vpc_id" { type = string, default = "" }
variable "eks_node_group_desired_size" { type = number, default = 2 }
variable "eks_node_group_min_size" { type = number, default = 1 }
variable "eks_node_group_max_size" { type = number, default = 3 }
variable "eks_node_instance_types" { type = list(string), default = ["t3.medium"] }

# Availability zones (passed from Gradle properties)
variable "eks_availability_zones" { type = list(string), default = [] }
variable "db_availability_zones" { type = list(string), default = [] }
