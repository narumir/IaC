resource "cloudflare_record" "bluesky" {
  zone_id = var.CLOUDFLARE_ZONE_ID
  name    = "_atproto"
  value   = "did=did:plc:pfzigorxnxx4oljx46bpvmri"
  type    = "TXT"
  comment = "Managed with terraform."
}

resource "cloudflare_record" "tistory" {
  zone_id = var.CLOUDFLARE_ZONE_ID
  name    = "log"
  value   = "host.tistory.io"
  type    = "CNAME"
  proxied = false
  comment = "Managed with terraform."
}

resource "cloudflare_record" "home" {
  zone_id = var.CLOUDFLARE_ZONE_ID
  name    = "home"
  value   = "175.197.17.80"
  type    = "A"
  proxied = true
  comment = "Managed with terraform."
}

resource "cloudflare_record" "aws_acm_global_narumir_io_certification" {
  for_each = {
    for dvo in aws_acm_certificate.narumir_io_global.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  zone_id         = var.CLOUDFLARE_ZONE_ID
  allow_overwrite = true
  proxied         = false
  name            = each.value.name
  type            = each.value.type
  value           = each.value.record
  ttl             = 1
  comment         = "Managed with terraform."
}

resource "cloudflare_record" "blog" {
  zone_id         = var.CLOUDFLARE_ZONE_ID
  allow_overwrite = true
  proxied         = false
  name            = "blog"
  type            = "CNAME"
  value           = aws_cloudfront_distribution.blog_ssr.domain_name
  comment         = "Managed with terraform."
}
