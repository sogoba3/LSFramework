variable "project_prefix" {type = string}
variable "service_name" {
  type = string
  description = "The name of the specific microservice"
}
variable "ls_framework_ecs_cluster_name" {
  type = string
  description = ""
}
variable "buildspec_path" {
  type = string
}

variable "dockerfile_path" {
  type = string
}
variable "ls_framework_ecs_task_execution_role_arn" {
  type = string
}
variable "ls_framework_ecs_task_role_arn" {
  type = string
}
variable "ls_framework_pipeline_artifacts_bucket_arn" {
  type = string
}
variable "github_connection" {
  type = string
}
variable "ls_framework_pipeline_artifacts_bucket" {
  type = string
}
# variable "ls_framework_source_path_filter" {
#   type = string
# }


# variable "repo" {}
