variable "aws_region" { type = string }
variable "tags" { type = map(string), default = {} }

variable "name" { type = string }
variable "username" { type = string }
variable "password" { type = string, sensitive = true }
variable "instance_class" { type = string }
variable "engine" { type = string, default = "postgres" }
variable "engine_version" { type = string, default = "16" }
variable "allocated_storage_gb" { type = number, default = 20 }
variable "subnet_ids" { type = list(string), default = [] }
variable "vpc_id" { type = string }
variable "vpc_security_group_ids" { type = list(string), default = [] }
