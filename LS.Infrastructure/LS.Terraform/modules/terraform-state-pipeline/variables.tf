variable "project_prefix" {type = string}
variable "service_name" {
  type = string
  description = "The name of the specific microservice"
}
variable "ls_framework_pipeline_artifacts_bucket_arn" {
  type = string
}
variable "ls_framework_pipeline_artifacts_bucket" {
  type = string
}
variable "github_connection" {
  type = string
}

variable "ls_framework_terraform_state_bucket_arn" {
  type = string
}
# variable "github_repository" {
#   type = string
# }