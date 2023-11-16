output "OKTA_OIDC_CLIENT_ID" {
 description = "Aws cli oidc client id" 
 value = okta_app_oauth.sso_cli.client_id
}