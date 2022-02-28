#Iam Lambda Login
resource "aws_iam_role" "lambda_login" {
   name = "lambda_login"
   assume_role_policy = data.aws_iam_policy_document.lambda_login.json
}

resource "aws_iam_policy" "lambda_login_policy" {
  name        = "Login_Policy"
  description = "Necessary resources"
  policy      = data.aws_iam_policy_document.lambda_login_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_login" {
  role       = aws_iam_role.lambda_login.name
  policy_arn = aws_iam_policy.lambda_login_policy.arn
}

data "aws_iam_policy_document" "lambda_login" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_login_policy" {
  statement {
    effect = "Allow"
    actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "cognito-idp:DescribeUserPool",
        "cognito-idp:CreateUserPoolClient",
        "cognito-idp:DeleteUserPoolClient",
        "cognito-idp:UpdateUserPoolClient",
        "cognito-idp:DescribeUserPoolClient",
        "cognito-idp:AdminInitiateAuth",
        "cognito-idp:AdminUserGlobalSignOut",
        "cognito-idp:ListUserPoolClients",
        "cognito-identity:DescribeIdentityPool",
        "cognito-identity:UpdateIdentityPool",
        "cognito-identity:GetIdentityPoolRoles",
        "cognito-idp:ListUserPoolClients" 
    ]
    resources = [
      "*"
    ]
  }
}

#Iam Lambda Upload Single Photo
resource "aws_iam_role" "lambda_upload" {
   name = "lambda_upload"
   assume_role_policy = data.aws_iam_policy_document.lambda_upload.json
}

resource "aws_iam_policy" "lambda_upload_policy" {
  name        = "Upload_Policy"
  description = "Necessary resources"
  policy      = data.aws_iam_policy_document.lambda_upload_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_upload" {
  role       = aws_iam_role.lambda_upload.name
  policy_arn = aws_iam_policy.lambda_upload_policy.arn
}

data "aws_iam_policy_document" "lambda_upload" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_upload_policy" {
  statement {
    effect = "Allow"
    actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "s3:PutObject"
    ]
    resources = [
      "*"
    ]
  }
}

#Iam Lambda Download Single Photo
resource "aws_iam_role" "lambda_download" {
   name = "lambda_download"
   assume_role_policy = data.aws_iam_policy_document.lambda_download.json
}

resource "aws_iam_policy" "lambda_download_policy" {
  name        = "Download_Policy"
  description = "Necessary resources"
  policy      = data.aws_iam_policy_document.lambda_download_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_download" {
  role       = aws_iam_role.lambda_download.name
  policy_arn = aws_iam_policy.lambda_download_policy.arn
}

data "aws_iam_policy_document" "lambda_download" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_download_policy" {
  statement {
    effect = "Allow"
    actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "s3:GetObject"
    ]
    resources = [
      "*"
    ]
  }
}

#Iam Lambda Delete Single Photo
resource "aws_iam_role" "lambda_delete" {
   name = "lambda_delete"
   assume_role_policy = data.aws_iam_policy_document.lambda_delete.json
}

resource "aws_iam_policy" "lambda_delete_policy" {
  name        = "delete_Policy"
  description = "Necessary resources"
  policy      = data.aws_iam_policy_document.lambda_delete_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_delete" {
  role       = aws_iam_role.lambda_delete.name
  policy_arn = aws_iam_policy.lambda_delete_policy.arn
}

data "aws_iam_policy_document" "lambda_delete" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_delete_policy" {
  statement {
    effect = "Allow"
    actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "s3:GetObjectAcl",
        "s3:DeleteObject"
    ]
    resources = [
      "*"
    ]
  }
}

#Iam Lambda Unzip
resource "aws_iam_role" "lambda_unzip" {
   name = "lambda_unzip"
   assume_role_policy = data.aws_iam_policy_document.lambda_unzip.json
}

resource "aws_iam_policy" "lambda_unzip_policy" {
  name        = "unzip_Policy"
  description = "Necessary resources"
  policy      = data.aws_iam_policy_document.lambda_unzip_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_unzip" {
  role       = aws_iam_role.lambda_unzip.name
  policy_arn = aws_iam_policy.lambda_unzip_policy.arn
}

data "aws_iam_policy_document" "lambda_unzip" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_unzip_policy" {
  statement {
    effect = "Allow"
    actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "s3:PutObject"
    ]
    resources = [
      "*"
    ]
  }
}

#Iam Lambda List

resource "aws_iam_role" "lambda_list" {
   name = "lambda_list"
   assume_role_policy = data.aws_iam_policy_document.lambda_list.json
}

resource "aws_iam_policy" "lambda_list_policy" {
  name        = "list_Policy"
  description = "Necessary resources"
  policy      = data.aws_iam_policy_document.lambda_list_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_list" {
  role       = aws_iam_role.lambda_list.name
  policy_arn = aws_iam_policy.lambda_list_policy.arn
}

data "aws_iam_policy_document" "lambda_list" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_list_policy" {
  statement {
    effect = "Allow"
    actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "s3:ListBucket",
    ]
    resources = [
      "*"
    ]
  }
}