terraform {
  required_version = ">= 1.11.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "example-bucket-9fe15070986d"
    region = "us-east-1"
    key    = "04-backends/state.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
}