variable "project_prefix" {type = string}

variable "ls_framework_sqlserver_password" {
  type = string
  sensitive = true
}
variable "ls_framework_sqlserver_username" {
  type        = string
  default = "admin"
  description = "The SQL Server admin username for the LS framework"
}
# variable "ls_framework_sqlserver_endpoint" {
#   type = string
# }

# variable "ls_framework_vpc_id" {
#   type        = string
#   description = "The VPC ID passed down from the network module"
# }

# variable "ls_framework_ecs_service_sg_id" {
#   type = string
#   description = "The Security group Id of LS Framework ECS Service"
# }

### db
variable "ls_framework_sqlserver_db_key_arn" {
  type = string
  description = ""
}

# variable "ls_framework_db_subnet_group_name" {
#   type = string
#   description = ""
# }
variable "ls_framework_frontend_s3_distribution_arn" {
  type = string
}
variable "ls_framework_cognito_UserPoolId" {
  type = string
}
variable "ls_framework_cognito_ClientId" {
  type = string
}