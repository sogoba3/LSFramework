variable "service_name" {
  type = string
  description = "The name of the specific microservice"
}
variable "cpu" {
  type = string
}
variable "memory" {
  type = string
}
variable "ls_framework_ecr_repository_url" {
  type = string
}
variable "aws_region" {
  type = string
}
variable "project_prefix" {type = string}
variable "log_retention_days" {
  type = number
}
variable "ls_framework_ecs_cluster_id" {
  type = string
}
variable "desired_count" {
  type = number
}
variable "ls_framework_private_subnets" {
  type = list(string)
  description = ""
}
variable "ls_framework_vpc_id" {
  type        = string
  description = "The VPC ID passed down from the network module"
}

variable "ls_framework_sqlserver_secret_arn" {
  type = string
}
variable "ls_framework_sqlserver_endpoint" {
  type = string
}