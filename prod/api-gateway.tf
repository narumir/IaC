resource "aws_apigatewayv2_api" "blog_gateway" {
  name          = "blog-gateway"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_domain_name" "blog_domain" {
  domain_name = "www.narumir.io"
  domain_name_configuration {
    certificate_arn = aws_acm_certificate.seoul_domain_certification.arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_apigatewayv2_api_mapping" "domain_mapping" {
  api_id      = aws_apigatewayv2_api.blog_gateway.id
  domain_name = aws_apigatewayv2_domain_name.blog_domain.domain_name
  stage       = aws_apigatewayv2_stage.lambda.id
}

resource "aws_apigatewayv2_stage" "lambda" {
  api_id = aws_apigatewayv2_api.blog_gateway.id

  name        = "prod"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.blog_api_gw.arn

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

resource "aws_apigatewayv2_integration" "hello_world" {
  api_id = aws_apigatewayv2_api.blog_gateway.id

  integration_uri    = aws_lambda_function.blog_ssr.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "hello_world" {
  api_id = aws_apigatewayv2_api.blog_gateway.id

  route_key = "GET /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.hello_world.id}"
}
