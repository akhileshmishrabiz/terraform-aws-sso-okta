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

variable "sso_role_name" {
  type        = string
  description = " sso role name"
  default     = "aws-okta-sso-test"
}

variable "sso_user" {
  type        = string
  description = " sso user name"
  default     = "aws_sso_user"
}

variable "saml_app_label" {
  type        = string
  description = " sso okta app label"
  default     = "aws-sso-test"
}

variable "oidc_app_label" {
  type        = string
  description = "oidc  app label"
  default     = "sso-aws-cli"
}

variable "aws_iam_identity_provider" {
  type        = string
  description = " iam identity provider name"
  default     = "aws-sso-okta-test"
}