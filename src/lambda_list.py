import boto3
import json
import array
import base64
import layer

def lambda_handler(event, lambda_context):

    email = layer.extract_credentials(event)

    
    s3_client =boto3.client('s3')
    s3_bucket="yoursafeplace"

    
    keys = s3_client.list_objects_v2(Bucket=s3_bucket, Prefix=email + "/")

    list = []
    for my_object in keys["Contents"]:
        print(keys["Contents"])
        list.append(my_object["Key"])
    print(list)
    json_format = json.dumps(list)
    


    return{
      'body': json_format,
    }