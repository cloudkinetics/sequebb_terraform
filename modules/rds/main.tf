#creating rds 
resource "aws_db_instance" "db_instance" {
  allocated_storage      = var.allocated_storage
  db_name                = var.db_name
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  identifier             = var.identifier
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.name
  vpc_security_group_ids = var.vpc_security_group_ids
  multi_az               = var.multi_az
  username               = var.username
  password               = var.password
  skip_final_snapshot    = var.skip_final_snapshot
  availability_zone      = var.rds_az
  apply_immediately = true
}
# creating db subnet group
resource "aws_db_subnet_group" "subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids
  tags = {
    Environment = var.Environment
  }
}

