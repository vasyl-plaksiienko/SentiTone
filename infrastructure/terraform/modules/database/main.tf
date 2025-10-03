resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-db-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = merge(var.tags, { Name = "${var.name}-db-subnet-group" })
}

resource "aws_security_group" "db" {
  name        = "${var.name}-db-sg"
  description = "DB security group (no ingress by default)"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(var.tags, { Name = "${var.name}-db-sg" })
}

locals {
  db_sg_ids = length(var.vpc_security_group_ids) > 0 ? concat([aws_security_group.db.id], var.vpc_security_group_ids) : [aws_security_group.db.id]
}

resource "aws_db_instance" "this" {
  identifier                 = "${var.name}-rds"
  allocated_storage          = var.allocated_storage_gb
  engine                     = var.engine
  engine_version             = var.engine_version
  instance_class             = var.instance_class
  db_name                    = var.name
  username                   = var.username
  password                   = var.password
  skip_final_snapshot        = true
  deletion_protection        = false
  apply_immediately          = true
  publicly_accessible        = false
  vpc_security_group_ids     = local.db_sg_ids
  db_subnet_group_name       = aws_db_subnet_group.this.name
  tags                       = merge(var.tags, { Name = "${var.name}-rds" })
}

output "endpoint" {
  description = "RDS endpoint hostname"
  value       = aws_db_instance.this.address
}
