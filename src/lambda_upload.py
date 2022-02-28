import json
import boto3
import base64
import datetime
import time
import layer

def lambda_handler(event, context):
   s3_client =boto3.client('s3')
   s3_bucket="yoursafeplace"
   
   file_content=event["body"]
   content_decoded=base64.b64decode(file_content)
   
   email = layer.extract_credentials(event)
   
   #timestamp
   st = datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d_%H:%M:%S') +".png"
   
   #Create directory using username. Uploading file with timestamp + filename
   s3_upload =s3_client.put_object(Bucket=s3_bucket, Key=email+"/"+st, Body=content_decoded)
   return {
       'statusCode': 200,
       'body': json.dumps('uploaded'),
   }