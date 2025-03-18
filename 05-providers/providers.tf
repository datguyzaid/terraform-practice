terraform {
  required_version = ">= 1.11.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  region = "us-east-2"
  alias  = "us-east-2"
}

resource "aws_s3_bucket" "bucket_us_east_1" {
  bucket = "example-bucket-123456789-aabbcc"
}

resource "aws_s3_bucket" "bucket_us_east_2" {
  bucket = "example-bucket-123456789-ddeeffgg"
  provider = aws.us-east-2
}