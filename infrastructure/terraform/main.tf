data "aws_default_vpc" "main_vpc" {}

module "database" {
  source               = "./modules/database"
  aws_region           = var.aws_region
  tags                 = var.tags
  name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  instance_class       = var.db_instance_class
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  allocated_storage_gb = var.db_allocated_storage
  subnet_ids           = var.db_subnet_ids
  vpc_id               = data.aws_default_vpc.main_vpc.id
}

module "eks" {
  source              = "./modules/eks"
  cluster_name        = var.eks_cluster_name
  eks_version         = var.eks_version
  subnet_ids          = var.eks_subnet_ids
  vpc_id              = data.aws_default_vpc.main_vpc.id
  node_group_desired  = var.eks_node_group_desired_size
  node_group_min      = var.eks_node_group_min_size
  node_group_max      = var.eks_node_group_max_size
  node_instance_types = var.eks_node_instance_types
  tags                = var.tags
}

output "database_endpoint" {
  description = "RDS instance endpoint"
  value       = module.database.endpoint
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}
