variable "environment" {
  type        = string
  description = "Environment name to apply to"
}

variable "aws_account_id" {
  type        = string
  description = " Accoubnt id for aws "
}

variable "org_name" {
  type        = string
  description = " okta organisation namne "
}

variable "base_url" {
  type        = string
  description = " base_url for okta "
}

variable "api_token" {
  type        = string
  description = " okta API token "
}

variable "region" {
  type        = string
  description = " aws region"
}
