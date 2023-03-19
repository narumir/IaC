resource "aws_lambda_function" "blog_ssr" {
  s3_key           = "blog.zip"
  function_name    = "blog-ssr"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "server.handler"
  # source_code_hash = filebase64sha256("blog.zip")
  source_code_hash = data.archive_file.blog_frontend_code.output_base64sha256
  runtime          = "nodejs16.x"
  s3_bucket        = aws_s3_bucket.blog_frontend.id
}

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.blog_ssr.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.blog_gateway.execution_arn}/*/*"
}
