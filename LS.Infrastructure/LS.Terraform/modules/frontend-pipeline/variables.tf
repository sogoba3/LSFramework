variable "project_prefix" {type = string}
variable "service_name" {
  type = string
  description = "The name of the specific microservice"
}
variable "ls_framework_frontend_bucket_name" {
  type = string
}
variable "ls_framework_cloudfront_distribution_id" {
  type = string
}
variable "ls_framework_frontend_bucket_arn" {
  type = string
}
variable "ls_framework_pipeline_artifacts_bucket" {
  type = string
}
variable "ls_framework_pipeline_artifacts_bucket_arn" {
  type = string
}