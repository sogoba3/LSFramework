### LS Framework project prefixes
variable "aws_region" { type = string }
variable "project_name" { type = string }
variable "environment" { type = string }
variable "managed_by" { type = string }
variable "service_names" {
  type = object({
    ecr_repo_name           = string
    gateway_api_name        = string
    auth_user_api_name      = string
    tenant_api_name         = string
    appointment_api_name    = string
    audit_api_name          = string
    billing_api_name        = string
    doctor_api_name         = string
    file_service_api_name   = string
    notification_api_name   = string
    patient_api_name        = string
    worker_service_api_name = string
  })
  description = ""
}
variable "services" {
  type = map(object({
    name = string
  }))
}
variable "api_services_config" {
  type = map(object({
    cpu                = string
    memory             = string
    port               = optional(number, 0)
    container_port     = number
    is_web_service     = bool
    routing_port       = number
    routing_test_port  = number
    health_check_path  = string
    log_retention_days = number
    desired_count      = number

    buildspec     = string
    dockerfile    = string
    source_folder = optional(string)
  }))
}

### Network Input variables
variable "vpc_cidr" {
  type        = string
  description = ""
}
variable "public_subnet_cidrs" {
  type        = list(string)
  description = ""
}
variable "private_subnet_cidrs" {
  type        = list(string)
  description = ""
}
variable "private_db_subnet_cidrs" {
  type        = list(string)
  description = ""
}
variable "ls_framework_sqlserver_password" {
  type        = string
  description = ""
  sensitive   = true
}
variable "ls_framework_sqlserver_username" {
  type        = string
  description = ""
  sensitive   = true
}
variable "ls_framework_domain_name" {
  type = string
}

variable "ls_framework_cognito_UserPoolId" {
  type = string
}
variable "ls_framework_cognito_ClientId" {
  type = string
}

# variable "deployment_type" {
#   type = string
#   # "BLUE_GREEN" | "ECS_ROLLING"
# }


