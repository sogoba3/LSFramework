output "ls_framework_blue_green_codepipeline_name" {
  value = aws_codepipeline.ls_framework_codepipeline.name
}

output "ls_framework_blue_green_deployment_group_name" {
  value = aws_codedeploy_deployment_group.ls_framework_blue_green_deployment_group.deployment_group_name
}