#Cognito
resource "aws_cognito_user_pool_domain" "main" {
  domain       = "accessdomain"
  user_pool_id = aws_cognito_user_pool.AccessGroup1.id
}

resource "aws_cognito_user_pool" "AccessGroup1" {
  name                       = "AccessGroup1"
  mfa_configuration          = "OFF"
  username_attributes = ["email"]
  schema {
    name                     = "email"
    string_attribute_constraints {
      min_length = 7
      max_length = 50
    }
    attribute_data_type      = "String"
    required          = true

  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  password_policy {
    minimum_length                   = "6"
    require_numbers                  = "true"
    require_lowercase                = "true"
    require_symbols                  = "true"
    require_uppercase                = "true"
    temporary_password_validity_days = "1"
  }

  username_configuration {
    case_sensitive = "true"
  }
}

resource "aws_cognito_user_pool_client" "client" {
  name                  = "AccessClient1"
  user_pool_id          =  "${aws_cognito_user_pool.AccessGroup1.id}"
  callback_urls = ["https://www.example.com/callback"] 
  allowed_oauth_flows = ["implicit"]
  allowed_oauth_scopes = ["email", "openid"]
  supported_identity_providers = ["COGNITO"]
  generate_secret       = false
  explicit_auth_flows   = ["ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_ADMIN_USER_PASSWORD_AUTH"]
}