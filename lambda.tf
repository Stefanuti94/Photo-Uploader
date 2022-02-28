#Lambda Login
data "archive_file" "lambda_zip" {
    type          = "zip"
    source_file   = "${path.module}/src/lambda_login.py"
    output_path   = "lambda_login_function.zip"
}

resource "aws_lambda_function" "lambda_login" {
  filename         = "lambda_login_function.zip"
  function_name    = var.lambda_function_name
  role             = aws_iam_role.lambda_login.arn
  handler          = "lambda_login.lambda_handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "python3.9"
   depends_on = [
    aws_iam_role_policy_attachment.lambda_login,
    aws_cloudwatch_log_group.lambda_login_logs,
  ]
  environment {
    variables = {
      UserPoolId = aws_cognito_user_pool.AccessGroup1.id
      ClientId = aws_cognito_user_pool_client.client.id
    }
  }
}

resource "aws_cloudwatch_log_group" "lambda_login_logs" {
  name = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 5
}

#Lambda Upload Single Photo
data "archive_file" "lambda_zip_upload" {
    type          = "zip"
    source_file   = "${path.module}/src/lambda_upload.py"
    output_path   = "lambda_upload_function.zip"
}

resource "aws_lambda_function" "lambda_upload" {
  filename         = "lambda_upload_function.zip"
  function_name    = "lambda_upload"
  role             = aws_iam_role.lambda_upload.arn
  handler          = "lambda_upload.lambda_handler"
  source_code_hash = data.archive_file.lambda_zip_upload.output_base64sha256
  runtime          = "python3.9"
  layers = [aws_lambda_layer_version.lambda_layer.arn]
   depends_on = [
    aws_iam_role_policy_attachment.lambda_upload,
    aws_cloudwatch_log_group.lambda_upload_logs,
  ]
  environment {
    variables = {
      UserPoolId = aws_cognito_user_pool.AccessGroup1.id
      ClientId = aws_cognito_user_pool_client.client.id
    }
  }
}


resource "aws_cloudwatch_log_group" "lambda_upload_logs" {
  name = "/aws/lambda/lambda_upload"
  retention_in_days = 5
}

#Lambda Download

data "archive_file" "lambda_download" {
    type          = "zip"
    source_file   = "${path.module}/src/lambda_download.py"
    output_path   = "lambda_download_function.zip"
}

resource "aws_lambda_function" "lambda_download" {
  filename         = "lambda_download_function.zip"
  function_name    = "lambda_download"
  role             = aws_iam_role.lambda_download.arn
  handler          = "lambda_download.lambda_handler"
  source_code_hash = data.archive_file.lambda_download.output_base64sha256 
  runtime          = "python3.9"
  layers = [aws_lambda_layer_version.lambda_layer.arn]
   depends_on = [
    aws_iam_role_policy_attachment.lambda_download,
    aws_cloudwatch_log_group.lambda_download_logs,
  ]
  environment {
    variables = {
      UserPoolId = aws_cognito_user_pool.AccessGroup1.id
      ClientId = aws_cognito_user_pool_client.client.id
    }
  }
}


resource "aws_cloudwatch_log_group" "lambda_download_logs" {
  name = "/aws/lambda/lambda_download"
  retention_in_days = 5
}

#Lambda Delete

data "archive_file" "lambda_delete" {
    type          = "zip"
    source_file   = "${path.module}/src/lambda_delete.py"
    output_path   = "lambda_delete_function.zip"
}

resource "aws_lambda_function" "lambda_delete" {
  filename         = "lambda_delete_function.zip"
  function_name    = "lambda_delete"
  role             = aws_iam_role.lambda_delete.arn
  handler          = "lambda_delete.lambda_handler"
  source_code_hash = data.archive_file.lambda_delete.output_base64sha256
  runtime          = "python3.9"
  layers = [aws_lambda_layer_version.lambda_layer.arn]
   depends_on = [
    aws_iam_role_policy_attachment.lambda_delete,
    aws_cloudwatch_log_group.lambda_delete_logs,
  ]
  environment {
    variables = {
      UserPoolId = aws_cognito_user_pool.AccessGroup1.id
      ClientId = aws_cognito_user_pool_client.client.id
    }
  }
}


resource "aws_cloudwatch_log_group" "lambda_delete_logs" {
  name = "/aws/lambda/lambda_delete"
  retention_in_days = 5
}

#Lambda Unzip

data "archive_file" "lambda_unzip" {
    type          = "zip"
    source_file   = "${path.module}/src/lambda_unzip.py"
    output_path   = "lambda_unzip_function.zip"
}

resource "aws_lambda_function" "lambda_unzip" {
  filename         = "lambda_unzip_function.zip"
  function_name    = "lambda_unzip"
  role             = aws_iam_role.lambda_unzip.arn
  handler          = "lambda_unzip.lambda_handler"
  source_code_hash = data.archive_file.lambda_unzip.output_base64sha256
  runtime          = "python3.9"
  layers = [aws_lambda_layer_version.lambda_layer.arn]
   depends_on = [
    aws_iam_role_policy_attachment.lambda_unzip,
    aws_cloudwatch_log_group.lambda_unzip_logs,
  ]
  environment {
    variables = {
      UserPoolId = aws_cognito_user_pool.AccessGroup1.id
      ClientId = aws_cognito_user_pool_client.client.id
    }
  }
}

resource "aws_cloudwatch_log_group" "lambda_unzip_logs" {
  name = "/aws/lambda/lambda_unzip"
  retention_in_days = 5
}

#Lambda List
data "archive_file" "lambda_list" {
    type          = "zip"
    source_file   = "${path.module}/src/lambda_list.py"
    output_path   = "lambda_list_function.zip"
}

resource "aws_lambda_function" "lambda_list" {
  filename         = "lambda_list_function.zip"
  function_name    = "lambda_list"
  role             = aws_iam_role.lambda_list.arn
  handler          = "lambda_list.lambda_handler"
  source_code_hash = data.archive_file.lambda_list.output_base64sha256
  runtime          = "python3.9"
  layers = [aws_lambda_layer_version.lambda_layer.arn]
   depends_on = [
    aws_iam_role_policy_attachment.lambda_list,
    aws_cloudwatch_log_group.lambda_list_logs,
  ]
  environment {
    variables = {
      UserPoolId = aws_cognito_user_pool.AccessGroup1.id
      ClientId = aws_cognito_user_pool_client.client.id
    }
  }
}


resource "aws_cloudwatch_log_group" "lambda_list_logs" {
  name = "/aws/lambda/lambda_list"
  retention_in_days = 5
}

#Lambda Layer
data "archive_file" "lambda-archive" {
  type        = "zip"
  source_dir  = "layers"
  output_path = "layer.zip"
}

resource "aws_lambda_layer_version" "lambda_layer" {
  filename   = "layer.zip"
  layer_name = "mylayer"
  compatible_runtimes = ["python3.9"]
  source_code_hash = data.archive_file.lambda-archive.output_base64sha256
}