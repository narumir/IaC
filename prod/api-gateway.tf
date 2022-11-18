resource "aws_apigatewayv2_api" "blog_gateway" {
  name          = "blog-gateway"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_domain_name" "blog_domain" {
  domain_name = "www.narumir.io"
  domain_name_configuration {
    certificate_arn = aws_acm_certificate.domain_certification.arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}
