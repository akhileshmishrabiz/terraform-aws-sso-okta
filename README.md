<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.0 |
| <a name="requirement_okta"></a> [okta](#requirement\_okta) | ~> 4.6.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.0 |
| <a name="provider_okta"></a> [okta](#provider\_okta) | ~> 4.6.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.sso](https://registry.terraform.io/providers/hashicorp/aws/5.0/docs/resources/iam_access_key) | resource |
| [aws_iam_policy.sso](https://registry.terraform.io/providers/hashicorp/aws/5.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.sso_user](https://registry.terraform.io/providers/hashicorp/aws/5.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.sso](https://registry.terraform.io/providers/hashicorp/aws/5.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.sso](https://registry.terraform.io/providers/hashicorp/aws/5.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_saml_provider.sso](https://registry.terraform.io/providers/hashicorp/aws/5.0/docs/resources/iam_saml_provider) | resource |
| [aws_iam_user.sso_user](https://registry.terraform.io/providers/hashicorp/aws/5.0/docs/resources/iam_user) | resource |
| [aws_iam_user_policy_attachment.sso](https://registry.terraform.io/providers/hashicorp/aws/5.0/docs/resources/iam_user_policy_attachment) | resource |
| [okta_app_group_assignment.aws_cli](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_group_assignment) | resource |
| [okta_app_group_assignment.sso](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_group_assignment) | resource |
| [okta_app_oauth.sso_cli](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_oauth) | resource |
| [okta_app_oauth_api_scope.sso_cli](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_oauth_api_scope) | resource |
| [okta_app_saml.sso](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_saml) | resource |
| [okta_app_saml_app_settings.sso](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_saml_app_settings) | resource |
| [okta_group.sso](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/group) | resource |
| [okta_group_memberships.sso_user](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/group_memberships) | resource |
| [okta_user.sso](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_token"></a> [api\_token](#input\_api\_token) | okta API token | `string` | n/a | yes |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | Accoubnt id for aws | `string` | n/a | yes |
| <a name="input_aws_iam_identity_provider"></a> [aws\_iam\_identity\_provider](#input\_aws\_iam\_identity\_provider) | iam identity provider name | `string` | `"aws-sso-okta-test"` | no |
| <a name="input_base_url"></a> [base\_url](#input\_base\_url) | base\_url for okta | `string` | n/a | yes |
| <a name="input_oidc_app_label"></a> [oidc\_app\_label](#input\_oidc\_app\_label) | oidc  app label | `string` | `"sso-aws-cli"` | no |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | okta organisation namne | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | aws region | `string` | n/a | yes |
| <a name="input_saml_app_label"></a> [saml\_app\_label](#input\_saml\_app\_label) | sso okta app label | `string` | `"aws-sso-test"` | no |
| <a name="input_sso_role_name"></a> [sso\_role\_name](#input\_sso\_role\_name) | sso role name | `string` | `"aws-okta-sso-test"` | no |
| <a name="input_sso_user"></a> [sso\_user](#input\_sso\_user) | sso user name | `string` | `"aws_sso_user"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_OKTA_OIDC_CLIENT_ID"></a> [OKTA\_OIDC\_CLIENT\_ID](#output\_OKTA\_OIDC\_CLIENT\_ID) | Aws cli oidc client id |
<!-- END_TF_DOCS -->