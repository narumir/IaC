resource "aws_cloudwatch_log_group" "narumir_blog_lambda" {
  name              = "/aws/lambda/${aws_lambda_function.narumir_blog.function_name}"
  retention_in_days = 30
  # 로그 보존일 30일
}
# 사실 이거 안쓰지 않나? 공식문서에도 로그가 없다고 본거 같은데 

resource "aws_cloudwatch_log_group" "narumir_blog_api_gw" {
  name              = "/aws/api_gw/${aws_apigatewayv2_api.narumir_blog.name}"
  retention_in_days = 30
  # 로그 보존일 30일
}
