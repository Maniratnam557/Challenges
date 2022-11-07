import requests

URL="http://169.254.169.254/latest/meta-data" #intanceMetadataService api 
r=requests.get(URL)
data=r.json()
print("the json data")
print(data)


