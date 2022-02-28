import logging
import base64
import boto3
import os
from zipfile import ZipFile
import io
import json
import datetime
import time
import layer

def lambda_handler(event, context):
    s3_client = boto3.client('s3')
    s3_bucket="yoursafeplace"
    response = {}
    file_content = base64.b64decode(event['body'])
    content_decoded=base64.b64decode(file_content)
    putObjects = []
    
    email = layer.extract_credentials(event)
    
    st = datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d_%H:%M:%S')
    try:
        with io.BytesIO(file_content) as tf:
            tf.seek(0)

            # Read the file as a zipfile and process the members
            with ZipFile(tf, mode='r') as zipf:
                for file in zipf.infolist():
                    fileName = file.filename
                    print(fileName)
                    if fileName.lower().endswith(('.png', '.jpg')):
                        putFile = s3_client.put_object(Bucket=s3_bucket, Key=email+"/"+st+fileName, Body=zipf.read(file))
                        putObjects.append(putFile)
        response['body'] = 'Your file has been uploaded'

        return response

    except Exception as e:
        raise IOError(e)
