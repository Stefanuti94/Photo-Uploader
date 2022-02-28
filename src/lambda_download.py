import boto3
import json
import array
import base64
import layer

def lambda_handler(event, lambda_context):
  
  filename=event['queryStringParameters']['filename']
  s3_client =boto3.client('s3')
  s3_bucket="yoursafeplace"

  s3_key = layer.extract_credentials(event)
  
  s3_client = boto3.client('s3')
  response = s3_client.generate_presigned_url('get_object', Params={'Bucket': s3_bucket, 'Key': s3_key+ "/" +filename}, ExpiresIn= 3600)


  return{
    'body': response
  }
  
