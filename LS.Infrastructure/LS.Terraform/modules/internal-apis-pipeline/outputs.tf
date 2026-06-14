output "ls_framework_ecs_rolling_build" {
  value = aws_codebuild_project.ls_framework_ecs_rolling_build.name
}
output "ls_framework_ecs_rolling_codepipeline" {
  value = aws_codepipeline.ls_framework_codepipeline.name
}