variable "AWS_ACCESS_KEY_ID" {
  type = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  type = string
}

variable "narumir_io_domain" {
  default = "narumir.io"
}

resource "random_uuid" "blog_ssr_bucket" {}

data "aws_ssm_parameter" "blog_prod_ssh_public_key" {
  name            = "/blog/prod/ssh_public_key"
  with_decryption = true
}

data "aws_ssm_parameter" "cloudflare_account_id" {
  name            = "/cloudflare/account_id"
  with_decryption = true
}

data "aws_ssm_parameter" "cloudflare_narumir_io_zone_id" {
  name            = "/cloudflare/narumir.io/zone_id"
  with_decryption = true
}

data "aws_ssm_parameter" "cloudflare_narumir_io_api_token" {
  name            = "/cloudflare/narumir.io/api_token"
  with_decryption = true
}

data "aws_ssm_parameter" "cloudflare_r2_access_key" {
  name            = "/cloudflare/r2/access_key"
  with_decryption = true
}

data "aws_ssm_parameter" "cloudflare_r2_secret_key" {
  name            = "/cloudflare/r2/secret_key"
  with_decryption = true
}

data "aws_caller_identity" "current" {}
