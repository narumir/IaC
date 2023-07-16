resource "aws_lambda_function" "blog_ssr" {
  handler = "server.handler"
  runtime = "nodejs18.x"
  function_name    = "blog_ssr"
  memory_size      = 1024
  timeout          = 6
  role             = aws_iam_role.lambda_exec.arn
  filename         = "blog_ssr.zip"
  source_code_hash = filebase64sha256("blog_ssr.zip")
  # 추후 s3 버켓으로 
}

resource "aws_lambda_permission" "blog_ssr" {
  function_name = aws_lambda_function.blog_ssr.function_name
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.blog_ssr.execution_arn}/*"
}
