# Photo-Uploader

Content
1) Purpose
2) Amazon Services & Tech stack
3) Automation
4) Authentication
5) Api
6) Lambda
7) Name convention for S3 Bucket
8) Diagram & Logic
 

1)Purpose
 
 The purpose of this document is to present an automation solution. You will find details about API, Cognito, Layer, S3. Also here you will find information and diagrams on how the services are interconnected.
 
2)Tech stack
To accomplish the goal we will use the following:
-Terraform 1.14
-Python3.8+
-AWS CodeCommit
-AWS CodeBuild
-AWS CodePipeline
-AWS Lambda
-AWS Cognito
-API Gateway
-AWS S3
 

3)Automation
For automation we will use CodeCommit to keep the TF code and CodePipeline to deploy it. These will be made manually from the AWS Console(for the moment). We will have a single repo called v1repo.
The tfstate will be kept in a separate bucket. S3 bucket will be called terraform-remote–state.
Also the buildspec.yml will be kept into v1repo.
The deployment of the infrastructure will be done automatically after each push in repo.


4)Authentication

![Authorisation](https://user-images.githubusercontent.com/82667872/155982400-bfa7de99-4bbd-44ca-a2a5-b075419844d9.png)
 
 
1) The customer sends the credentials to Cognito.
2) Cognito validates them and sends back the JWT.
3) When the client tries to access the required API, it needs an access token that is obtained from JWT.
4) The API forwards the token to Cognito for validation.
5) Cognito sends the token confirmation back to the API.


5)API

We will use 6 APIs to upload/download/delete the files from our S3 Bucket.

a) 	/login
The /login endpoint returns a JWT token used for Api Gateway authentication.
POST /login
This endpoint requires that the username and password are present in the BODY.
Request parameters in body
username - Cognito username (email)
password - Cognito user’s password


Sample request:
POST https://ucm240nnie.execute-api.eu-central-1.amazonaws.com/test/login 
	-H "Content-Type: application/json"
	-d '{"username": "UserEmailAddress", "password": "UserPassword"}'

Sample response:
	{"jwt": "token",
           "credentials": "UserEmailAdress"}

b) 	/upload_single_photo
Api to upload a single photo to S3
  	 POST /upload_single_photo
This endpoint requires that the JWT token is present in the headers.
Request parameters
-H "Content-Type: application/json"
-H “Authorization: JWT”
Request parameters in body
Add the file data to the request body.

c)	/unzip
Api to upload an archive with multiple photos to S3
 POST/unzip
This endpoint requires that the JWT token is present in the headers.
 Request parameters
-H "Content-Type: application/json"
-H “Authorization: JWT”

Request parameters in body
Add the file data to the request body.

d) 	/download
Api to retrieve a photo from S3
 POST /download
This endpoint requires that the JWT token is present in the headers.
 Request parameters in headers
-H "Content-Type: application/json"
-H “Authorization: JWT”
Request parameters in params
"filename: NameOfTheApp"

e)    /list
 API to list all user’s photos as JSON
 POST /list
This endpoint requires that the JWT token is present in the headers.
  Request parameters
 -H "Content-Type: application/json"
 -H “Authorization: JWT”

f)     /delete
API to delete a photo from S3
 POST /delete
This endpoint requires that the JWT token is present in the headers.
 Request parameters
 -H "Content-Type: application/json"
 -H “Authorization: JWT”
 Request parameters in params
"file: NameOfTheApp"

6) Lambda.
We will have 6 lambda functions. Each function will be connected with a separate API.
These functions will integrate certain capabilities such as JWT decoding. This capability will help us extract the username from the JWT and make folders for each user. We will also need to list objects from S3 when we need to download a photo. Timestamp will be added directly from the function to effectively remove overwriting of a document.
Function list: lambda_login, lambda_upload, lambda_list, lambda_delete, lambda_unzip, lambda_download.
We will use Lambda-layer. Only the repetitive code will be written here.
Lambda layer will be used for the following functions: lambda_upload, lambda_list, lambda_delete, lambda_unzip, lambda_download.
 
 
7) Name convention for S3 Bucket
 
S3 bucket for photos will be called: yourplace
In our bucket we will store only images. These objects will have a user-named part and in addition we will use a name convention timestamp that will be added automatically when the client uploads the file.


8) Diagram & Logic

![Diagram](https://user-images.githubusercontent.com/82667872/155982869-7af3a2d5-e4ce-4cf6-89d5-dcbac5c7d0cc.png)

1 -> User will send a request to cognito to create a username and a password.
2 -> Users will access an API. Here, the user will send the requested information.
3 -> Api Gateway will check with Cognito if the user exists or not.
4 -> A lambda will be triggered automatically when the user will access a specific API.
5 -> Lambda will upload/download/list as per request from API
6/7 -> Logs will be stored in CloudWatch.
