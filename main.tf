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
