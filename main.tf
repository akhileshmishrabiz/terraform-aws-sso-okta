# #https://github.com/mscribellito/terraform-aws-okta-sso/tree/main

# okta app
import {
  id = "0oa601ey48N2X0VNK0x7"
  to = okta_app_saml.sso
}

import {
  id = "0oa60ylb4nJRb97x30x7"
  to = okta_app_oauth.sso_cli
}

import {
  to = okta_app_oauth_api_scope.sso_cli
  id = "0oa60ylb4nJRb97x30x7"

}
import {
  id = "arn:aws:iam::521296171486:saml-provider/aws-sso-okta-test"
  to = aws_iam_saml_provider.sso
}

# okta app settings
import {
  id = "0oa601ey48N2X0VNK0x7"
  to = okta_app_saml_app_settings.sso
}

# iam role
import {
  id = "aws-okta-sso-test"
  to = aws_iam_role.sso
}

# iam policy 
import {
  id = "arn:aws:iam::521296171486:policy/sso-readonly-nonprod-other-policy"
  to = aws_iam_policy.sso_iam_policy
}


#okta group
import {
  id = "00g601pc23ObYIMuy0x7"
  to = okta_group.sso
}

# okta app assignment
import {
  id = "0oa601ey48N2X0VNK0x7/00g601pc23ObYIMuy0x7"
  to = okta_app_group_assignment.sso
}

# okta app assignment oidc app
import {
  id = "0oa60ylb4nJRb97x30x7/00g601pc23ObYIMuy0x7"
  to = okta_app_group_assignment.sso_cli
}

import {
  id = "00u5ez4uv5N0Yliqd0x7"
  to = okta_user.sso
}
