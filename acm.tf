resource "aws_acm_certificate" "narumir_io_global" {
  domain_name       = "*.narumir.io"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
    # elb와 같은 서비스에서 항상 사용중 이기 때문에 인증서를 삭제 전에 인증서를 생성하고 갱신 해야 한다.
  }
  provider = aws.global
  # 글로벌 인증서 이기에 us-east-1에 인증서를 생성해야 한다.
}

resource "aws_acm_certificate_validation" "narumir_io_global_validation" {
  certificate_arn         = aws_acm_certificate.narumir_io_global.arn
  validation_record_fqdns = [for record in cloudflare_record.aws_acm_global_narumir_io_certification : record.hostname]
  provider                = aws.global
}
resource "aws_acm_certificate" "narumir_io_seoul" {
  domain_name       = "*.narumir.io"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
    # elb와 같은 서비스에서 항상 사용중 이기 때문에 인증서를 삭제 전에 인증서를 생성하고 갱신 해야 한다.
  }
  depends_on = [aws_acm_certificate.narumir_io_global]
  # 도메인 인증에 필요한 DNS Record는 공동으로 똑같이 나오기 때문에 global이 먼저 생성되어야 한다.
}

resource "aws_acm_certificate_validation" "narumir_io_seoul_validation" {
  certificate_arn         = aws_acm_certificate.narumir_io_seoul.arn
  validation_record_fqdns = [for record in cloudflare_record.aws_acm_global_narumir_io_certification : record.hostname]
  # 도메인 인증에 필요한 DNS Record는 공동으로 똑같이 나오기 때문에 global에서 생성된 값을 공동으로 사용
}
