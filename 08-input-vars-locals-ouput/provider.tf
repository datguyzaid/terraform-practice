terraform {
  required_version = "~> 1.11"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.84"
    }
  }
}

# NOT RECOMMENDED TO CONFIGURE PROVIDERS WITH VARIABLES AS STATE WILL BE OVERRIDDEN WHEN VALUE CHANGES!
provider "aws" {
  region = "us-east-1"
}
