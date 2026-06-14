variable "project_prefix" {type = string}
# variable "ls_framework_domain_name" {
#     type = string
# }
variable "ls_framework_frontend_bucket_regional_domain_name" {
  type = string
}
# variable "ls_framework_frontend_bucket_id" {
#   type = string
# }


# variable "environment" {
#   default = "dev"
# }

variable "enable_dns" {
  default = false
}

variable "enable_cloudfront_custom_domain" {
  default = false
}