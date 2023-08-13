resource "aws_cloudfront_distribution" "blog_ssr" {
  enabled = true
  origin {
    domain_name = "${aws_api_gateway_rest_api.blog_ssr.id}.execute-api.ap-northeast-2.amazonaws.com"
    origin_id   = aws_api_gateway_rest_api.blog_ssr.id

    custom_origin_config {
      http_port                = "80"
      https_port               = "443"
      origin_protocol_policy   = "https-only"
      origin_ssl_protocols     = ["TLSv1.2"]
      origin_keepalive_timeout = 5
      origin_read_timeout      = 30
    }
    origin_path = "/prod"
    # origin_shield {
    #   enabled              = false
    #   origin_shield_region = "ap-northeast-2"
    # }
    connection_attempts = 3
    connection_timeout  = 10
  }

  default_cache_behavior {
    target_origin_id         = aws_api_gateway_rest_api.blog_ssr.id
    compress                 = true
    viewer_protocol_policy   = "redirect-to-https"
    allowed_methods          = ["GET", "HEAD", "POST"]
    cache_policy_id          = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad" # CachingDisabled
    origin_request_policy_id = "b689b0a8-53d0-40ab-baf2-68738e2966ac" # AllViewerExceptHostHeader
    smooth_streaming         = false
    cached_methods           = ["GET", "HEAD"]

    # field_level_encryption_id = 
    # realtime_log_config_arn = 
  }
  # 함수연결 
  # web_acl_id = 
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  aliases = ["blog.narumir.io"]
  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = aws_acm_certificate.narumir_io_global.arn
    minimum_protocol_version       = "TLSv1.2_2018"
    ssl_support_method             = "sni-only"
  }
  # http_version = "http3"
  http_version = "http2and3"
  # default_root_object = "index.html"
  # logging_config {
  #   enabled = false
  # }
  is_ipv6_enabled = true
  # comment = ""
}
