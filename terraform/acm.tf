resource "aws_acm_certificate" "narumir_io" {
  domain_name       = "*.narumir.io"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "narumir_io" {
  certificate_arn         = aws_acm_certificate.narumir_io.arn
  validation_record_fqdns = [for record in cloudflare_record.aws_narumir_io_certification : record.hostname]
}
