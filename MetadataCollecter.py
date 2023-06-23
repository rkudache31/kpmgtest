#!/bin/python
#################################################################################################
## Script Name :- metadatacollector.py                                       
## Description :- Meta data of an instance within AWS or Azure or GCP and provide a json formatted output.                              
## Auther :-   Ravindra Kudache       
#################################################################################################
import requests
import json

#Use this document to understand about URL https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/instancedata-data-retrieval.html
def get_aws_instance_metadata():
    response = requests.get('http://169.254.169.254/latest/dynamic/instance-identity/document')
    metadata = response.json()
    return metadata

#Use this document to understand about URL https://learn.microsoft.com/en-us/azure/virtual-machines/instance-metadata-service?tabs=linux
def get_azure_instance_metadata():
    response = requests.get('http://169.254.169.254/metadata/instance?api-version=2021-02-01', headers={'Metadata': 'true'})
    metadata = response.json()
    return metadata

#Use this document to understand about URL https://download.huihoo.com/google/gdgdevkit/DVD1/developers.google.com/compute/docs/metadata.html
def get_gcp_instance_metadata():
    response = requests.get('http://metadata.google.internal/computeMetadata/v1/?recursive=true', headers={'Metadata-Flavor': 'Google'})
    metadata = {}
    for line in response.text.splitlines():
        key, value = line.split(': ')
        metadata[key] = value
    return metadata

#Calling GET function
aws_metadata = get_aws_instance_metadata()
azure_metadata = get_azure_instance_metadata()
gcp_metadata = get_gcp_instance_metadata()

# Convert metadata to JSON format
aws_json = json.dumps(aws_metadata, indent=4)
azure_json = json.dumps(azure_metadata, indent=4)
gcp_json = json.dumps(gcp_metadata, indent=4)

print("AWS Metadata:")
print(aws_json)

print("\nAzure Metadata:")
print(azure_json)

print("\nGCP Metadata:")
print(gcp_json)

