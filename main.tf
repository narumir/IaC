terraform {
  backend "s3" {
    bucket = "narumir-tfstate"
    key    = "terraform/narumir"
    region = "ap-northeast-2"
  }
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~>4.9.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.40"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
    }
  }
  required_version = ">= 1.2.0"
}

provider "cloudflare" {
  api_token = var.CLOUDFLARE_API_TOKEN
}

provider "aws" {
  access_key                  = var.CLOUDFLARE_R2_ACCESS_KEY
  secret_key                  = var.CLOUDFLARE_R2_SECRET_KEY
  alias                       = "cloudflare_r2"
  region                      = "us-east-1"
  # S3는 글로벌 설정이라 미 설정시 ap-northeast-2로 적용되서 오류 발생
  skip_credentials_validation = true
  skip_region_validation      = true
  skip_requesting_account_id  = true
  endpoints {
    s3 = "https://${var.CLOUDFLARE_ACCOUNT_ID}.r2.cloudflarestorage.com"
  }
}

provider "aws" {
  region     = "ap-northeast-2"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

provider "aws" {
  region     = "us-east-1"
  alias      = "global"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}
