terraform {
  required_version = "1.5.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.0"
    }
    okta = {
      source  = "okta/okta"
      version = "~> 4.6.1"
    }
  }
}
