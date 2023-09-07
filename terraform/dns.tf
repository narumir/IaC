resource "cloudflare_record" "bluesky" {
  zone_id = data.aws_ssm_parameter.cloudflare_narumir_io_zone_id.value
  name    = "_atproto"
  value   = "did=did:plc:pfzigorxnxx4oljx46bpvmri"
  type    = "TXT"
  comment = "Managed with terraform."
}

resource "cloudflare_record" "tistory" {
  zone_id = data.aws_ssm_parameter.cloudflare_narumir_io_zone_id.value
  name    = "log"
  value   = "host.tistory.io"
  type    = "CNAME"
  proxied = false
  comment = "Managed with terraform."
}

resource "cloudflare_record" "wiki-blog" {
  zone_id         = data.aws_ssm_parameter.cloudflare_narumir_io_zone_id.value
  allow_overwrite = true
  proxied         = true
  name            = "wiki-blog"
  type            = "CNAME"
  value           = "narumir.github.io"
  comment         = "Managed with terraform."
}

resource "cloudflare_record" "blog_ipv4" {
  zone_id         = data.aws_ssm_parameter.cloudflare_narumir_io_zone_id.value
  allow_overwrite = true
  proxied         = true
  name            = "blog"
  type            = "A"
  value           = data.aws_ssm_parameter.jacob_ip.value
  comment         = "Managed with terraform."
}

resource "cloudflare_record" "blog_api_ipv4" {
  zone_id         = data.aws_ssm_parameter.cloudflare_narumir_io_zone_id.value
  allow_overwrite = true
  proxied         = true
  name            = "api-blog"
  type            = "A"
  value           = data.aws_ssm_parameter.jacob_ip.value
  comment         = "Managed with terraform."
}

resource "cloudflare_record" "argocd" {
  zone_id         = data.aws_ssm_parameter.cloudflare_narumir_io_zone_id.value
  allow_overwrite = true
  proxied         = false
  name            = "argocd"
  type            = "A"
  value           = data.aws_ssm_parameter.jacob_ip.value
  comment         = "Managed with terraform."
}

resource "cloudflare_record" "aws_narumir_io_certification" {
  for_each = {
    for dvo in aws_acm_certificate.narumir_io.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  zone_id         = data.aws_ssm_parameter.cloudflare_narumir_io_zone_id.value
  allow_overwrite = true
  proxied         = false
  name            = each.value.name
  type            = each.value.type
  value           = each.value.record
  ttl             = 1
  comment         = "Managed with terraform."
}

resource "cloudflare_record" "blog_content" {
  zone_id         = data.aws_ssm_parameter.cloudflare_narumir_io_zone_id.value
  allow_overwrite = true
  proxied         = false
  name            = "content-blog"
  type            = "CNAME"
  value           = aws_apigatewayv2_domain_name.blog-content.domain_name_configuration[0].target_domain_name
  comment         = "Managed with terraform."
}
