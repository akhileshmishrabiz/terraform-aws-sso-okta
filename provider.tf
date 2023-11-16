provider "aws" {
  region              = var.region
}

provider "okta" {
  org_name  = var.org_name
  base_url  = var.base_url
  api_token = var.api_token
}


######################################################
## If youb are using vault to keep the okta details ##
######################################################
# provider "okta" {
#   org_name  = data.vault_generic_secret.okta.data["org_name"]
#   base_url  = data.vault_generic_secret.okta.data["base_url"]
#   api_token = data.vault_generic_secret.okta.data["api_token"]
# }

# data "vault_generic_secret" "okta" {
#   path = "path-to-okta-vault-secret"
# }

# provider "vault" {
#   address = "url-to-self-hosted-vault"
# }
########################################################################
