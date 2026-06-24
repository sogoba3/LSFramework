variable "project_prefix" {type = string}
variable "aws_region" {
  type = string
}
variable "service_name" {
  type = string
  description = "The name of the specific microservice"
}
variable "container_port" {
  type = number
  validation {
    condition     = var.container_port == 0 || (var.container_port >= 1 && var.container_port <= 65535)
    error_message = "The container_port must be 0 (for non-web services) or between 1 and 65535."
  }
}
variable "cpu" {
  type = string
}
variable "memory" {
  type = string
}
variable "log_retention_days" {
  type = number
}

variable "ls_framework_ecr_repository_url" {
  type = string
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
variable "ls_framework_tenant_api_base_url" {
  type = string
}
variable "ls_framework_cognito_user_pool_arn" {
  type = string
}


# variable "ls_framework_internal_alb_dns_name" {
#   type = string
# }

# variable "desired_count" {
#   type = number
# }
# variable "ls_framework_private_subnets" {
#   type = list(string)
#   description = ""
# }
# variable "health_check_path" {
#   type = string
# }
# variable "is_web_service" {
#   type        = bool
#   default     = true
#   description = "Set to false for background workers that do not need an ALB or CodeDeploy"
# }
# variable "is_gateway_service" {
#   type    = bool
#   default = false
# }
# variable "ls_framework_ecs_cluster_id" {
#   type = string
# }
