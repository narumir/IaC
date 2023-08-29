terraform {
  backend "s3" {
    bucket = "narumir-terraform"
    key    = "terraform.tfstate"
    region = "ap-northeast-2"
  }
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~>4.13.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.14"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.80.0"
    }
  }
  required_version = ">= 1.5.6"
}

provider "cloudflare" {
  api_token = data.aws_ssm_parameter.cloudflare_narumir_io_api_token.value
}

provider "aws" {
  region     = "ap-northeast-2"
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

provider "google" {
  project     = "narumir"
  region      = "asia-northeast3"
  credentials = data.aws_ssm_parameter.google_credentials
}
