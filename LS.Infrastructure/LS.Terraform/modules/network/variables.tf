variable "project_prefix" {type = string}
variable "aws_region" {
  type = string
}
variable "vpc_cidr" {
  type = string
  description = "VPC CIDR"
}
variable "public_subnet_cidrs" {
  type = list(string)
  description = "List of CIDR blocks for public subnets"
}
variable "private_subnet_cidrs" {
  type = list(string)
  description = "List of CIDR blocks for private subnets"
}
variable "private_db_subnet_cidrs" {
  type = list(string)
  description = "List of CIDR blocks for private db subnets"
}
variable "destination_cidr_block" {
  type = string
  default = "0.0.0.0/0"
}
variable "ls_framework_ecs_service_sg_id" {
  type = map(string)
}


