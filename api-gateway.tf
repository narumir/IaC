resource "aws_api_gateway_rest_api" "blog_ssr" {
  name               = "blog_ssr_gw"
  binary_media_types = ["*/*"]
  endpoint_configuration {
    types = ["EDGE"]
  }
}

resource "aws_api_gateway_method" "blog_ssr_root" {
  http_method      = "ANY"
  resource_id      = aws_api_gateway_rest_api.blog_ssr.root_resource_id
  rest_api_id      = aws_api_gateway_rest_api.blog_ssr.id
  api_key_required = false
  authorization    = "NONE"
}

resource "aws_api_gateway_integration" "blog_ssr_root" {
  rest_api_id             = aws_api_gateway_rest_api.blog_ssr.id
  resource_id             = aws_api_gateway_rest_api.blog_ssr.root_resource_id
  http_method             = aws_api_gateway_method.blog_ssr_root.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.blog_ssr.invoke_arn
}

resource "aws_api_gateway_resource" "blog_ssr_proxy" {
  parent_id   = aws_api_gateway_rest_api.blog_ssr.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.blog_ssr.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "blog_ssr_proxy" {
  http_method      = "ANY"
  resource_id      = aws_api_gateway_resource.blog_ssr_proxy.id
  rest_api_id      = aws_api_gateway_rest_api.blog_ssr.id
  api_key_required = false
  authorization    = "NONE"
}

resource "aws_api_gateway_integration" "blog_ssr_proxy" {
  rest_api_id             = aws_api_gateway_rest_api.blog_ssr.id
  resource_id             = aws_api_gateway_resource.blog_ssr_proxy.id
  http_method             = aws_api_gateway_method.blog_ssr_proxy.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.blog_ssr.invoke_arn
}

resource "aws_api_gateway_deployment" "blog_ssr" {
  rest_api_id = aws_api_gateway_rest_api.blog_ssr.id
  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.blog_ssr.body))
  }
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [
    aws_api_gateway_integration.blog_ssr_root,
    aws_api_gateway_integration.blog_ssr_proxy
  ]
}

resource "aws_api_gateway_stage" "blog_ssr" {
  deployment_id = aws_api_gateway_deployment.blog_ssr.id
  rest_api_id   = aws_api_gateway_rest_api.blog_ssr.id
  stage_name    = "prod"
}
