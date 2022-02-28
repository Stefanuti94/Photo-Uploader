#Api
#Rest Api
resource "aws_api_gateway_rest_api" "myapi" {
  name        = "myapi"
  description = "This is my API for demonstration purposes"
  binary_media_types = ["images/png", "application/json"]
   endpoint_configuration {
    types = ["REGIONAL"]
   }
}

# Deployment & Stage API
resource "aws_api_gateway_deployment" "live" {
  rest_api_id = aws_api_gateway_rest_api.myapi.id
  depends_on = [
    aws_api_gateway_method.login, aws_api_gateway_integration.login,
    aws_api_gateway_method.upload_single_photo, aws_api_gateway_integration.upload_single_photo,
    aws_api_gateway_method.download, aws_api_gateway_integration.download,
    aws_api_gateway_method.delete, aws_api_gateway_integration.delete,
    aws_api_gateway_method.unzip, aws_api_gateway_integration.unzip,
    aws_api_gateway_method.list, aws_api_gateway_integration.list,
  ]

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.myapi.id))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "live" {
  deployment_id = aws_api_gateway_deployment.live.id
  rest_api_id   = aws_api_gateway_rest_api.myapi.id
  stage_name    = "live"
}

#Api Login
resource "aws_api_gateway_resource" "login" {
  rest_api_id = aws_api_gateway_rest_api.myapi.id
  parent_id   = aws_api_gateway_rest_api.myapi.root_resource_id 
  path_part   = "login"
}

resource "aws_api_gateway_method" "login" {
  rest_api_id   = aws_api_gateway_rest_api.myapi.id
  resource_id   = aws_api_gateway_resource.login.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "login" {
  rest_api_id             = aws_api_gateway_rest_api.myapi.id
  resource_id             = aws_api_gateway_resource.login.id
  http_method             = aws_api_gateway_method.login.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_login.invoke_arn
}

resource "aws_lambda_permission" "login" {
  statement_id  = "AllowmyapiInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_login.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.myapi.execution_arn}/*/*/*"
}

#API Upload Single Photo
resource "aws_api_gateway_resource" "upload_single_photo" {
  rest_api_id = aws_api_gateway_rest_api.myapi.id
  parent_id   = aws_api_gateway_rest_api.myapi.root_resource_id 
  path_part   = "upload_single_photo"
}

resource "aws_api_gateway_method" "upload_single_photo" {
  rest_api_id   = aws_api_gateway_rest_api.myapi.id
  resource_id   = aws_api_gateway_resource.upload_single_photo.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.Live.id
}


resource "aws_api_gateway_integration" "upload_single_photo" {
  rest_api_id             = aws_api_gateway_rest_api.myapi.id
  resource_id             = aws_api_gateway_resource.upload_single_photo.id
  http_method             = aws_api_gateway_method.upload_single_photo.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_upload.invoke_arn
}



resource "aws_lambda_permission" "upload_single_photo" {
  statement_id  = "AllowmyapiInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_upload.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.myapi.execution_arn}/*/*/*"
}

#API Download
resource "aws_api_gateway_resource" "download" {
  rest_api_id = aws_api_gateway_rest_api.myapi.id
  parent_id   = aws_api_gateway_rest_api.myapi.root_resource_id 
  path_part   = "download"
}

resource "aws_api_gateway_method" "download" {
  rest_api_id   = aws_api_gateway_rest_api.myapi.id
  resource_id   = aws_api_gateway_resource.download.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.Live.id
}
resource "aws_api_gateway_integration" "download" {
  rest_api_id             = aws_api_gateway_rest_api.myapi.id
  resource_id             = aws_api_gateway_resource.download.id
  http_method             = aws_api_gateway_method.download.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_download.invoke_arn
}

resource "aws_lambda_permission" "download" {
  statement_id  = "AllowmyapiInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_download.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.myapi.execution_arn}/*/*/*"
}

#API Delete
resource "aws_api_gateway_resource" "delete" {
  rest_api_id = aws_api_gateway_rest_api.myapi.id
  parent_id   = aws_api_gateway_rest_api.myapi.root_resource_id 
  path_part   = "delete"
}

resource "aws_api_gateway_method" "delete" {
  rest_api_id   = aws_api_gateway_rest_api.myapi.id
  resource_id   = aws_api_gateway_resource.delete.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.Live.id
}
resource "aws_api_gateway_integration" "delete" {
  rest_api_id             = aws_api_gateway_rest_api.myapi.id
  resource_id             = aws_api_gateway_resource.delete.id
  http_method             = aws_api_gateway_method.delete.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_delete.invoke_arn
}

resource "aws_lambda_permission" "delete" {
  statement_id  = "AllowmyapiInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_delete.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.myapi.execution_arn}/*/*/*"
}

#API Unzip
resource "aws_api_gateway_resource" "unzip" {
  rest_api_id = aws_api_gateway_rest_api.myapi.id
  parent_id   = aws_api_gateway_rest_api.myapi.root_resource_id 
  path_part   = "unzip"
}

resource "aws_api_gateway_method" "unzip" {
  rest_api_id   = aws_api_gateway_rest_api.myapi.id
  resource_id   = aws_api_gateway_resource.unzip.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.Live.id
}
resource "aws_api_gateway_integration" "unzip" {
  rest_api_id             = aws_api_gateway_rest_api.myapi.id
  resource_id             = aws_api_gateway_resource.unzip.id
  http_method             = aws_api_gateway_method.unzip.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_unzip.invoke_arn
}

resource "aws_lambda_permission" "unzip" {
  statement_id  = "AllowmyapiInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_unzip.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.myapi.execution_arn}/*/*/*"
}

#API List
resource "aws_api_gateway_resource" "list" {
  rest_api_id = aws_api_gateway_rest_api.myapi.id
  parent_id   = aws_api_gateway_rest_api.myapi.root_resource_id 
  path_part   = "list"
}

resource "aws_api_gateway_method" "list" {
  rest_api_id   = aws_api_gateway_rest_api.myapi.id
  resource_id   = aws_api_gateway_resource.list.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.Live.id
}
resource "aws_api_gateway_integration" "list" {
  rest_api_id             = aws_api_gateway_rest_api.myapi.id
  resource_id             = aws_api_gateway_resource.list.id
  http_method             = aws_api_gateway_method.list.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_list.invoke_arn
}

resource "aws_lambda_permission" "list" {
  statement_id  = "AllowmyapiInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_list.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.myapi.execution_arn}/*/*/*"
}

resource "aws_api_gateway_authorizer" "Live" {

  type                   = "COGNITO_USER_POOLS"
  name                   = "Live"
  provider_arns          = [aws_cognito_user_pool.AccessGroup1.arn]
  rest_api_id            = aws_api_gateway_rest_api.myapi.id
    }