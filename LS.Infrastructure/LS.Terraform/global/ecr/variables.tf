variable "project_prefix" {type = string}

variable "service_name" {
  type = string
  description = "The name of the specific microservice"
}
variable "ls_framework_ecr_db_key_arn" {
  type = string
}