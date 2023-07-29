resource "aws_codedeploy_app" "blog_backend" {
  compute_platform = "Server"
  name             = "blog"
}

resource "aws_codedeploy_deployment_group" "blog_backend" {
  app_name              = aws_codedeploy_app.blog_backend.name
  deployment_group_name = "deploy_api"
  service_role_arn      = aws_iam_role.codedeploy_role.arn
  deployment_style {
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }
  ec2_tag_set {
    ec2_tag_filter {
      type  = "KEY_AND_VALUE"
      key   = "Type"
      value = "backend"
    }
    ec2_tag_filter {
      type  = "KEY_AND_VALUE"
      key   = "Service"
      value = "blog"
    }
  }
  deployment_config_name = "CodeDeployDefault.AllAtOnce"
}
