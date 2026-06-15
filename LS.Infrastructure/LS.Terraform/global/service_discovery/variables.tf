variable "ls_framework_vpc_id" {
  type = string
}

variable "services" {
  type = map(object({
    name = string
  }))
}