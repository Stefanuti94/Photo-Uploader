#Layer
def extract_credentials(event):
    import base64
    import json
    token=event['headers']['Authorization']
    x = token.split(".")[1]
    x += "=" * ((4 - len(x) % 4) % 4)
    auth=base64.b64decode(x)
    data = json.loads(auth)
    email = data["email"]
    return email
