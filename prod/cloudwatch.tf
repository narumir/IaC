resource "aws_cloudwatch_log_group" "blog_cloud_watch" {
  name              = "/aws/lambda/${aws_lambda_function.blog_ssr.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "blog_api_gw" {
  name              = "/aws/api_gw/${aws_apigatewayv2_api.blog_gateway.name}"
  retention_in_days = 30
}
