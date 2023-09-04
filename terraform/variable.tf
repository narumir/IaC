variable "AWS_ACCESS_KEY" {
  type = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  type = string
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

data "aws_ssm_parameter" "jacob_cidr" {
  name            = "/pc/jacob_cidr"
  with_decryption = true
}

data "aws_ssm_parameter" "jacob_ip" {
  name            = "/pc/jacob_ip"
  with_decryption = true
}

data "aws_caller_identity" "current" {}
