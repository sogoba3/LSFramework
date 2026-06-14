### LS Framework project prefixes
variable "aws_region" { type = string }
variable "project_name" { type = string }
variable "environment"  { type = string }
variable "managed_by"       { type = string }
variable "service_names" {
  type = list(string)
  description = ""
}

### Network Input variables
variable "vpc_cidr" {
  type = string
  description = ""
}
variable "public_subnet_cidrs" {
  type = list(string)
  description = ""
}
variable "private_subnet_cidrs" {
  type = list(string)
  description = ""
}
variable "private_db_subnet_cidrs" {
  type = list(string)
  description = ""
}

###
variable "ls_framework_ecr_repository_url_gateway" {
  type = string
  description = ""
}

variable "ls_framework_vpc_id" {
  type        = string
  description = "The VPC ID passed down from the network module"
}
variable "ls_framework_vpc_private_subnets" {
  type = list(string)
  description = ""
}
variable "ls_framework_vpc_cidr_block" {
  type = string
  description = ""
}

variable "ls_framework_sqlserver_password" {
  type = string
  description = ""
  sensitive = true
}
variable "ls_framework_sqlserver_username" {
  type = string
  description = ""
  sensitive = true
}