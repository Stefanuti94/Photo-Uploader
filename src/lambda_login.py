import boto3
import base64
import hashlib
import hmac
import json
import os

def lambda_handler(event, context):
    
    credentials = json.loads(event["body"])
    client = boto3.client('cognito-idp')

    auth_parameters = {
            'USERNAME': credentials["username"],
            'PASSWORD': credentials["password"]
        }

    try: 
        response = client.admin_initiate_auth(
        UserPoolId= os.environ["UserPoolId"],
        ClientId= os.environ["ClientId"], 
        AuthFlow='ADMIN_NO_SRP_AUTH',
        AuthParameters=auth_parameters
        )
        return {
            'statusCode': 200,
            "body": json.dumps({
                    'jwt': response["AuthenticationResult"]["IdToken"],
                    'credentials': credentials["username"]}) 
        }
        
    except client.exceptions.UserNotFoundException:
        return{
            "statusCode": 401,
            "body": ("UserNotFound")}
    except client.exceptions.NotAuthorizedException:
        return{
            "statusCode": 401,
            "body": ("NotAuthorized")}
    except client.exceptions.InvalidParameterException:
        return{
            "statusCode": 401,
            "body": ("InvalidUser")}