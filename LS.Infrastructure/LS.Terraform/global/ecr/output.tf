output "ls_framework_ecr_repository_url" {
  value = aws_ecr_repository.ls_framework_ecr_repository.repository_url
}

output "repository_name" {
  value = aws_ecr_repository.ls_framework_ecr_repository.name
}