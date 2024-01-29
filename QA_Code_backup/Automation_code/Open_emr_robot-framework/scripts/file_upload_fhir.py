import json
import uuid
from azure.storage.blob import BlobServiceClient, BlobClient
from azure.storage.blob import ContentSettings, ContainerClient

# f = open('..\\function_files\\dev_connection_string_non_fhir.json', )
# json_data = json.load(f)


def publish(uuid,json_data, env1, filename):
    upload_file_path = f'../dsp_daa_fhir_layering/configurationfiles/{env1}/base-infra/us_east/{filename}'
    print(upload_file_path)
    blob_service_client = BlobServiceClient.from_connection_string(json_data["Values"]['EXTERNAL_CONNECTION_STRING'])
    container_name = json_data["Values"]["DOCSPERA_ADLS_CONTAINER"]
    target_blob = f'{uuid}.json'
    blob_client = blob_service_client.get_blob_client(container=container_name, blob=target_blob)
    static_html_content_settings = ContentSettings(content_type='application/json')
    with open(upload_file_path, "rb") as data:
        blob_client.upload_blob(data, content_settings=static_html_content_settings)
    print("file uploaded successfully")


def check_blob_name(connection_str, cont_name, bl_name):
    blob = BlobClient.from_connection_string(conn_str=connection_str, container_name=cont_name, blob_name=bl_name)
    exists = blob.exists()
    print(exists)
    return exists

