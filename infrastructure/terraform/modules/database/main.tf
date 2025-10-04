resource "aws_db_subnet_group" "database_subnet_group" {
  name                        = "${var.identifier}-database-subnet-group"
  subnet_ids                  = var.subnet_ids
  tags                        = merge(var.tags, { Name = "${var.identifier}-database-subnet-group" })
}

resource "aws_security_group" "database_security_group" {
  name                        = "${var.identifier}-database-sg"
  vpc_id                      = var.vpc_id

  ingress {
    from_port                 = var.port
    to_port                   = var.port
    protocol                  = "TCP"
#    cidr_blocks               = var.accessible_from
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "${var.identifier}-database-sg" })
}

resource "aws_db_instance" "database" {
  identifier                  = var.identifier
  allocated_storage           = var.allocated_storage_gb
  engine                      = var.engine
  engine_version              = var.engine_version
  instance_class              = var.instance_class
  db_name                     = var.name
  username                    = var.username
  password                    = var.password
  port                        = var.port
  publicly_accessible         = var.accessible_public

  availability_zone           = var.availability_zone
  vpc_security_group_ids      = [aws_security_group.database_security_group.id]
  db_subnet_group_name        = aws_db_subnet_group.database_subnet_group.name

  auto_minor_version_upgrade  = true
  allow_major_version_upgrade = true
  skip_final_snapshot         = true
  tags                        = merge(var.tags, { Name = "${var.identifier}-rds" })
}

output "endpoint" {
  description                 = "RDS endpoint hostname"
  value                       = aws_db_instance.database.address
}
