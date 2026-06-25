variable "project_prefix" {type = string}
variable "ls_framework_ecs_cluster_id" {
  type = string
}
variable "service_name" {
  type = string
  description = "The name of the specific microservice"
}
variable "desired_count" {
  type = number
}
variable "ls_framework_private_subnets" {
  type = list(string)
  description = ""
}
# variable "ls_framework_ecs_service_sg_id" {
#   type = string
# }
variable "ls_framework_task_definition_arn" {
  type = string
}
variable "ls_framework_service_discovery_arn" {
  type = string
}
variable "ls_framework_vpc_id" {
  type        = string
  description = "The VPC ID passed down from the network module"
}
variable "ls_framework_gateway_service_sg_id" {
  type = string
}
variable "container_port" {
  type = number
  validation {
    condition     = var.container_port == 0 || (var.container_port >= 1 && var.container_port <= 65535)
    error_message = "The container_port must be 0 (for non-web services) or between 1 and 65535."
  }
}
variable "ls_framework_ecs_service_sg_ids" {
  type = map(string)
}