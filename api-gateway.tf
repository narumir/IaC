resource "aws_apigatewayv2_api" "narumir_blog" {
  name          = "narumir_blog"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_domain_name" "narumir_blog" {
  domain_name = "blog.narumir.io"
  domain_name_configuration {
    certificate_arn = aws_acm_certificate.narumir_io_seoul.arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_apigatewayv2_api_mapping" "domain_mapping" {
  api_id      = aws_apigatewayv2_api.narumir_blog.id
  domain_name = aws_apigatewayv2_domain_name.narumir_blog.domain_name
  stage       = aws_apigatewayv2_stage.narumir_blog_prod.id
}

resource "aws_apigatewayv2_stage" "narumir_blog_prod" {
  api_id      = aws_apigatewayv2_api.narumir_blog.id
  name        = "prod"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.narumir_blog_api_gw.arn
    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
}

resource "aws_apigatewayv2_integration" "narumir_blog" {
  api_id           = aws_apigatewayv2_api.narumir_blog.id
  integration_uri  = aws_lambda_function.narumir_blog.invoke_arn
  integration_type = "AWS_PROXY"
  # integration_method = "POST"
}

resource "aws_apigatewayv2_route" "hello_world" {
  api_id    = aws_apigatewayv2_api.narumir_blog.id
  route_key = "$default"
  target    = "integrations/${aws_apigatewayv2_integration.narumir_blog.id}"
}
