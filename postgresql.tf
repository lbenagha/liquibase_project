# PostgreSQL script
resource "aws_db_instance" "mydb" {
  allocated_storage        = 20 # gigabytes
  backup_retention_period  = 7   # in days
  engine                   = "postgres"
  engine_version           = "10.7"
  identifier               = "mydb"
  instance_class           = "db.t2.micro"
  name                     = "mydb"
  parameter_group_name     = "mydbpostgres" 
  password                 = "main4000"
  port                     = 5432
  publicly_accessible      = true
  # storage_encrypted        = true
  storage_type             = "gp2"
  username                 = "liquibase"
}