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
