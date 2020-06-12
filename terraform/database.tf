resource "aws_db_instance" "wordpress" {
  allocated_storage = 20
  storage_type      = "gp2"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t2.micro"
  name              = "wordpresstest"
  username          = var.mysql_username_wp
  password          = var.mysql_password_wp
  //  parameter_group_name        = "default.mysql5.7"
  db_subnet_group_name   = aws_db_subnet_group.rds-private-subnet.name
  vpc_security_group_ids = [aws_security_group.rds-sg.id]
  //  allow_major_version_upgrade = true
  //  auto_minor_version_upgrade  = true
  //  backup_retention_period     = 35
  //  backup_window               = "22:00-23:00"
  //  maintenance_window          = "Sat:00:00-Sat:03:00"
  //  multi_az                    = true
  //  skip_final_snapshot         = true
}

resource "aws_db_subnet_group" "rds-private-subnet" {
  name       = "rds-private-subnet-group"
  subnet_ids = [aws_subnet.subnet.id, aws_subnet.subnet_coverage.id]
}