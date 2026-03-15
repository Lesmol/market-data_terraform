terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  required_version = ">= 1.5"

  backend "s3" {
    bucket         = "v2-market-data-terraform-state"
    key            = "market-data/terraform.tfstate"
    region         = "af-south-1"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}
