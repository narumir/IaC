resource "aws_cloudwatch_log_group" "blog_ssr" {
  name              = "/aws/lambda/${aws_lambda_function.blog_ssr.function_name}"
  retention_in_days = 30
}
