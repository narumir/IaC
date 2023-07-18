resource "aws_lambda_function" "blog_ssr" {
  handler           = "server.handler"
  runtime           = "nodejs18.x"
  function_name     = "blog_ssr"
  memory_size       = 1024
  timeout           = 6
  role              = aws_iam_role.lambda_exec.arn
  s3_bucket         = data.aws_s3_object.blog_ssr_source_code.bucket
  s3_key            = data.aws_s3_object.blog_ssr_source_code.key
  s3_object_version = data.aws_s3_object.blog_ssr_source_code.version_id
}

resource "aws_lambda_permission" "blog_ssr" {
  function_name = aws_lambda_function.blog_ssr.function_name
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.blog_ssr.execution_arn}/*"
}
