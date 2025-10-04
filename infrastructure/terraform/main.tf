resource "aws_default_vpc" "main_vpc" {}

data "aws_subnet" "db_subnets" {
  for_each             = toset([var.db_availability_zone, "eu-west-1b"])
  availability_zone    = each.key
}

locals {
  tags                 = merge(var.tags, {Environment = var.environment_name})
}

module "database" {
  source               = "./modules/database"
  identifier           = "sentitone-${var.environment_name}"
  name                 = "sentitone"
  username             = var.db_username
  password             = var.db_password
  instance_class       = var.db_instance_class
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  allocated_storage_gb = var.db_allocated_storage
  port                 = 5432

  accessible_public    = true
  vpc_id               = aws_default_vpc.main_vpc.id
  accessible_from      = [for s in data.aws_subnet.db_subnets: s.cidr_block]
  availability_zone    = var.db_availability_zone
  subnet_ids           = [for s in data.aws_subnet.db_subnets: s.id]

  tags                 = local.tags
}

#module "eks" {
#  source              = "./modules/eks"
#  cluster_name        = var.eks_cluster_name
#  eks_version         = var.eks_version
#  subnet_ids          = var.eks_subnet_ids
#  vpc_id              = data.aws_default_vpc.main_vpc.id
#  node_group_desired  = var.eks_node_group_desired_size
#  node_group_min      = var.eks_node_group_min_size
#  node_group_max      = var.eks_node_group_max_size
#  node_instance_types = var.eks_node_instance_types
#  tags                = var.tags
#}

output "database_endpoint" {
  description = "RDS instance endpoint"
  value       = module.database.endpoint
}

#output "eks_cluster_name" {
#  value = module.eks.cluster_name
#}
