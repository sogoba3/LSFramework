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

variable "ls_framework_cognito_secret_arn" {
  type = string
}
variable "ls_framework_Audit_Log_Arn" {
  type = string
}
variable "ls_framework_Tenant_Admin_Signed_Up_Topic_Arn" {
  type = string
}
variable "ls_framework_Tenant_Admin_Signed_Up_Queue_Url" {
  type = string
}
variable "ls_framework_Tenant_Admin_Signed_Up_Queue_Arn" {
  type = string
}
# variable "ls_framework_tenant_api_base_url" {
#   type = string
# }
# variable "ls_framework_service_discovery_arn" {
#   type = string
# }