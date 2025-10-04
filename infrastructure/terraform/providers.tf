terraform {
  required_version = ">= 1.13.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.15.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
