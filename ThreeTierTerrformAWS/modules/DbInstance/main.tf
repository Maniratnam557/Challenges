resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [subnets[0],subnets[1]]

  tags = {
    Name = "DB subnet group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.default.id
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  multi_az               = true
  name                   = "mydb"
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  vpc_security_group_ids = var.security_groups
}

