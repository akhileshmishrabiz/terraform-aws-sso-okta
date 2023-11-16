# okta saml app for using aws preconfigured app
resource "okta_app_saml" "sso" {
  accessibility_self_service = false
  app_links_json = jsonencode({
    login = true
  })
  assertion_signed        = false
  auto_submit_toolbar     = true
  default_relay_state     = "https://eu-west-1.console.aws.amazon.com/"
  hide_ios                = false
  hide_web                = false
  honor_force_authn       = false
  implicit_assignment     = false
  label                   = var.saml_app_label
  preconfigured_app       = "amazon_aws"
  response_signed         = false
  saml_version            = "2.0"
  status                  = "ACTIVE"
  user_name_template      = "$${source.login}"
  user_name_template_type = "BUILT_IN"
}


# Create aws IAM identity provider
resource "aws_iam_saml_provider" "sso" {
  name                   = var.aws_iam_identity_provider
  saml_metadata_document = okta_app_saml.sso.metadata
}

# settings for okta saml app with aws_cli settings
resource "okta_app_saml_app_settings" "sso" {
  app_id = okta_app_saml.sso.id
  settings = jsonencode({
    appFilter           = "okta"
    awsEnvironmentType  = "aws.amazon"
    groupFilter         = "aws_(?{{accountid}}\\d+)_(?{{role}}[a-zA-Z0-9+=,.@\\-_]+)"
    identityProviderArn = aws_iam_saml_provider.sso.arn # IAM identity provider's arn created before
    joinAllRoles        = false
    loginURL            = "https://console.aws.amazon.com/"
    roleValuePattern    = "arn:aws:iam::$${accountid}:saml-provider/OKTA,arn:aws:iam::$${accountid}:role/$${role}"
    sessionDuration     = 3600
    useGroupMapping     = false
    webSSOAllowedClient = okta_app_oauth.sso_cli.client_id
    }
  )
}

# Creating Okta group
resource "okta_group" "sso" {
  name        = "aws-okta-sso-test-group"
  description = "aws sso group"
}

################
## IMPORTANT ###
#################
## Below block should be implemented after adding access keys/secret in okta app under provisioning. 
## Once application created, go to Application -> Provisioning -> Enable API Integration
## Edit provisioning to app and enable create user and update user attribute

# assigning Okta group with saml app
resource "okta_app_group_assignment" "sso" {
  app_id   = okta_app_saml.sso.id
  group_id = okta_group.sso.id
  profile = jsonencode(
    {
      role = null
      samlRoles = [
        "aws-sso-okta-test",
      ]
    }
  )
}

# Creating okta user
resource "okta_user" "sso" {
  department      = "Cloud"
  display_name    = "Akhilesh Mishra"
  email           = "primary email id "
  employee_number = "1234567"
  first_name      = "Akhilesh"
  last_name       = "Mishra"
  login           = "login email"
  second_email    = "secondary email id "
}

# Assigning user to the group
resource "okta_group_memberships" "sso_user" {
  group_id = okta_group.sso.id
  users = [
    okta_user.sso.id,
  ]
}

##########################

# OIDC nativ app for okta
resource "okta_app_oauth" "sso_cli" {
  accessibility_self_service = false
  app_links_json             = "{\"oidc_client_link\":true}"
  app_settings_json          = "{}"
  auto_key_rotation          = true
  auto_submit_toolbar        = false
  consent_method             = "REQUIRED"
  enduser_note               = null
  grant_types                = ["authorization_code", "urn:ietf:params:oauth:grant-type:device_code", "urn:ietf:params:oauth:grant-type:token-exchange"]
  hide_ios                   = true
  hide_web                   = true
  implicit_assignment        = false
  issuer_mode                = "DYNAMIC"
  label                      = var.oidc_app_label
  login_mode                 = "DISABLED"
  login_scopes               = []
  pkce_required              = true
  profile                    = null
  response_types             = ["code"]
  status                     = "ACTIVE"
  token_endpoint_auth_method = "none"
  tos_uri                    = null
  type                       = "native"
  user_name_template         = "$${source.login}"
  user_name_template_type    = "BUILT_IN"
  wildcard_redirect          = "DISABLED"
}

# Setting scope for okta native oidc app
resource "okta_app_oauth_api_scope" "sso_cli" {
  app_id = okta_app_oauth.sso_cli.client_id
  issuer = var.base_url
  scopes = ["okta.apps.read"]
}

# group assignment on oidc native app
resource "okta_app_group_assignment" "aws_cli" {
  app_id   = okta_app_oauth.sso_cli.id
  group_id = okta_group.sso.id
}