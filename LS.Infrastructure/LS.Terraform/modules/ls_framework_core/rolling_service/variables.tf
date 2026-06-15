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
variable "ls_framework_ecs_service_sg_id" {
  type = string
}
variable "ls_framework_task_definition_arn" {
  type = string
}
variable "ls_framework_service_discovery_arn" {
  type = string
}