variable "AWS_ACCESS_KEY_ID" {
  type = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  type = string
}

variable "AWS_BLOG_SSH_PUBLIC_KEY" {
  type = string
}

variable "CLOUDFLARE_ZONE_ID" {
  type = string
}

variable "CLOUDFLARE_ACCOUNT_ID" {
  type = string
}

variable "CLOUDFLARE_API_TOKEN" {
  type = string
}

variable "CLOUDFLARE_R2_ACCESS_KEY" {
  type = string
}

variable "CLOUDFLARE_R2_SECRET_KEY" {
  type = string
}

variable "narumir_io_domain" {
  default = "narumir.io"
}

resource "random_uuid" "blog_ssr_bucket" {}
