resource "aws_acm_certificate" "domain_certification" {
  domain_name       = "*.narumir.io"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
    # elb와 같은 서비스에서 항상 사용중 이기 때문에 인증서를 삭제 전에 인증서를 생성하고 갱신 해야 한다.
  }
}

resource "aws_acm_certificate" "global_domain_certification" {
  domain_name       = "*.narumir.io"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
    # elb와 같은 서비스에서 항상 사용중 이기 때문에 인증서를 삭제 전에 인증서를 생성하고 갱신 해야 한다.
  }
  provider = aws.global
}
