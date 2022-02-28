import boto3
import zipfile
import os
import base64
import hashlib
import hmac
import json
import layer

def lambda_handler(event, context):
    s3_client =boto3.client('s3')
    s3_bucket="yoursafeplace"
    file = event['queryStringParameters']['file']
    folder = layer.extract_credentials(event)
    
    key = f"{folder}" +"/" + f"{file}"

    try:
        s3_client.delete_object(Bucket=s3_bucket, Key=key)
        return{
            'body': json.dumps(f"{file} was deleted")
            
        }
    except Exception as e:
        return{
            'statusCode': 500
            
        }
