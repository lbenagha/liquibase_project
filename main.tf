# creating an ec2 instance
resource "aws_instance" "liquibase-project" {
  ami           = "ami-08f3d892de259504d"
  instance_type = "t2.micro"
  key_name = "devOps_instanceEC2"
    tags = {
      Name = "liquibase-ec2"
    }
  }

# liquibase security group default
resource "aws_security_group" "sg" {
  vpc_id = aws_default_vpc.default.id

  lifecycle {
    create_before_destroy = true
  }
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Creating default vpc
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

# Creating subnet
resource "aws_default_subnet" "default_east1" {
  availability_zone = "us-east-1a"
  
    tags = {
     Name = "Default subnet for us-east-1"
  }
}

# Creating an s3 bucket 
resource "aws_s3_bucket" "liquibase-buc" {
  bucket        = "liquibase-buc"
  acl           = "public-read"
}

# Creating a new load balancer
resource "aws_elb" "liquibase-elb" {
  name               = "Liquibase-SRE-Elb"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

  access_logs {
    bucket        = "liquibase-buc"
    bucket_prefix = "sre"
    interval      = 60
  }
  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  # listener {
  #  instance_port      = 8000
  #  instance_protocol  = "http"
  #  lb_port            = 443
  # lb_protocol        = "https"
  #  ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
  # }
    health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = [aws_instance.liquibase-project.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "Liquibase-SRE-Elb"
  }
}