resource "aws_codebuild_project" "ls_framework_terraform_codebuild_apply" {
  name         = "${var.service_name}-build-apply"
  service_role = aws_iam_role.ls_framework_terraform_state_codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "deploy/terraform-state/buildspec-apply.yml"
  }

  environment {
    type            = "LINUX_CONTAINER"
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    # privileged_mode = false
  }
}