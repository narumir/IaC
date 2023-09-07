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

provider "aws" {
  access_key                  = data.aws_ssm_parameter.cloudflare_r2_access_key.value
  secret_key                  = data.aws_ssm_parameter.cloudflare_r2_secret_key.value
  alias                       = "cloudflare"
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_region_validation      = true
  skip_requesting_account_id  = true
  endpoints {
    s3 = "https://${data.aws_ssm_parameter.cloudflare_account_id.value}.r2.cloudflarestorage.com"
  }
}
