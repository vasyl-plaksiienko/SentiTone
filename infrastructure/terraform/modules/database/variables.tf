variable "identifier" { type = string }
variable "name" { type = string }
variable "username" { type = string }
variable "password" {
  type = string
  sensitive = true
}
variable "instance_class" { type = string }
variable "engine" { type = string }
variable "engine_version" { type = string }
variable "allocated_storage_gb" { type = number }
variable "port" { type = number }
variable "vpc_id" { type = string }
variable "availability_zone" { type = string }
variable "accessible_public" { type = bool }
variable "accessible_from" { type = list(string) }
variable "subnet_ids" { type = list(string) }
variable "tags" { type = map(string) }