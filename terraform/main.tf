terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "example" {
  bucket        = var.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_cors_configuration" "example" {
  bucket = aws_s3_bucket.example.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "DELETE", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = []
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.example.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.example.id
  acl    = "private"

  depends_on = [
    aws_s3_bucket_public_access_block.example,
    aws_s3_bucket_ownership_controls.example,
  ]
}

# Bucket Policy to allow access only for the IAM user
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.example.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Sid" : "Stmt1625306057759",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : ["s3:*"],
        "Resource" : [
          "${aws_s3_bucket.example.arn}"
        ]
      }
    ]
  })
}

resource "aws_s3_access_point" "s3_access_point" {
  name   = var.s3_access_point_name
  bucket = aws_s3_bucket.example.id
}

resource "aws_db_instance" "postgresql_instance" {
  identifier             = var.db_identifier
  allocated_storage      = 15
  engine                 = "postgres"
  engine_version         = "14.7"
  instance_class         = "db.t3.micro"
  db_name                = var.postgres_db
  username               = var.postgres_username
  password               = var.postgres_password
  parameter_group_name   = "default.postgres14"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.default.id]
  publicly_accessible    = true

  tags = {
    Name = "My PostgreSQL DB"
  }
}

resource "aws_security_group" "default" {
  name_prefix = "default-"
}

resource "aws_security_group_rule" "ingress_postgres" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "egress_postgres" {
  type              = "egress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.default.id
}
