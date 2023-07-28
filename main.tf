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
  api_token = data.aws_ssm_parameter.cloudflare_narumir_io_api_token.value
}

provider "aws" {
  access_key = data.aws_ssm_parameter.cloudflare_r2_access_key.value
  secret_key = data.aws_ssm_parameter.cloudflare_r2_secret_key.value
  alias      = "cloudflare_r2"
  region     = "us-east-1"
  # S3는 글로벌 설정이라 미 설정시 ap-northeast-2로 적용되서 오류 발생
  skip_credentials_validation = true
  skip_region_validation      = true
  skip_requesting_account_id  = true
  endpoints {
    s3 = "https://${data.aws_ssm_parameter.cloudflare_account_id.value}.r2.cloudflarestorage.com"
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
