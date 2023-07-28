variable "region" {
  type    = string
  default = "us-east-1"
}

variable "bucket_name" {
  type    = string
  default = "aws-dev-udacity-prj3"
}

variable "s3_access_point_name" {
  type    = string
  default = "udagram"
}

variable "db_identifier" {
  type    = string
  default = "aws-dev-udacity-prj3"
}

variable "postgres_username" {
  type    = string
  default = "udacity"
}

variable "postgres_password" {
  type    = string
  default = "Abcd^1234"
}

variable "postgres_db" {
  type    = string
  default = "udacity-prj3"
}

variable "rds_security_group" {
  type    = string
  default = "udacity-prj3-rds-security-group"
}

variable "eks_cluster_role" {
  type    = string
  default = "udacity-prj3-eks-role"
}

variable "eks_security_group" {
  type    = string
  default = "udacity-prj3-eks-security-group"
}

variable "eks_cluster_name" {
  type    = string
  default = "udacity-prj3-eks"
}

variable "eks_worker_node_role" {
  type    = string
  default = "udacity-prj3-eks-worker-node-role"
}

variable "eks_worker_node" {
  type    = string
  default = "udacity-prj3-eks-worker-node"
}