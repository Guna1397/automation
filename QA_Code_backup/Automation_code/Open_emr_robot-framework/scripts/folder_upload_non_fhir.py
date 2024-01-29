import json
from azure.storage.blob import BlobServiceClient, BlobClient
from azure.storage.blob import ContentSettings, ContainerClient
import uuid

file_name_1 = uuid.uuid4()
file_name_2 = uuid.uuid4()
file_name_3 = uuid.uuid4()


def publish_checklist(json_data, env1):
    upload_file_path = '../dsp_daa_fhir_layering/configurationfiles/' + env1 + '/testdata/us_east/v1/2.16.840.1.113883.3.12345/non-fhir/checklist/checklist.json'
    blob_service_client = BlobServiceClient.from_connection_string(json_data["Values"]['EXTERNAL_CONNECTION_STRING'])
    container_name = json_data["Values"]["DSP_FHIR_CONTAINER"]
    target_blob = f"v1/2.16.840.1.113883.3.12345/non-fhir/checklist/{file_name_1}.json"
    blob_client = blob_service_client.get_blob_client(container=container_name, blob=target_blob)
    static_html_content_settings = ContentSettings(content_type='application/json')
    with open(upload_file_path, "rb") as data:
        blob_client.upload_blob(data, content_settings=static_html_content_settings)
    print("file uploaded successfully")


def publish_intake(json_data, env1):
    upload_file_path = '../dsp_daa_fhir_layering/configurationfiles/' + env1 + '/testdata/us_east/v1/2.16.840.1.113883.3.12345/non-fhir/intake/intake.json'
    blob_service_client = BlobServiceClient.from_connection_string(json_data["Values"]['EXTERNAL_CONNECTION_STRING'])
    container_name = json_data["Values"]["DSP_FHIR_CONTAINER"]
    target_blob = f"v1/2.16.840.1.113883.3.12345/non-fhir/intake/{file_name_2}.json"
    blob_client = blob_service_client.get_blob_client(container=container_name, blob=target_blob)
    static_html_content_settings = ContentSettings(content_type='application/json')
    with open(upload_file_path, "rb") as data:
        blob_client.upload_blob(data, content_settings=static_html_content_settings)
    print("file uploaded successfully")


def publish_intake_smart_scheduler(json_data, env1):
    upload_file_path = '../dsp_daa_fhir_layering/configurationfiles/' + env1 + '/testdata/us_east/v1/2.16.840.1.113883.3.12345/non-fhir/intake_smart_scheduler/intake_smart_scheduler.json'
    blob_service_client = BlobServiceClient.from_connection_string(json_data["Values"]['EXTERNAL_CONNECTION_STRING'])
    container_name = json_data["Values"]["DSP_FHIR_CONTAINER"]
    target_blob = f"v1/2.16.840.1.113883.3.12345/non-fhir/intake_smart_scheduler/{file_name_3}.json"
    blob_client = blob_service_client.get_blob_client(container=container_name, blob=target_blob)
    static_html_content_settings = ContentSettings(content_type='application/json')
    with open(upload_file_path, "rb") as data:
        blob_client.upload_blob(data, content_settings=static_html_content_settings)
    print("file uploaded successfully")


def check_list(connection_str, cont_name):
    bl_name= file_name_1
    blob_service_client = BlobServiceClient.from_connection_string(connection_str)
    dsp_non_fhir_blob_container_client = blob_service_client.get_container_client(container=cont_name)
    nonfhir_processing_blob_list = dsp_non_fhir_blob_container_client.list_blobs(
        name_starts_with="v1/2.16.840.1.113883.3.12345/non-fhir")
    for blob in nonfhir_processing_blob_list:
        print(bl_name)
        if str(bl_name) in str(blob.name):
            return True
    return False


def intake(connection_str, cont_name):
    bl_name = file_name_2
    blob_service_client = BlobServiceClient.from_connection_string(connection_str)
    dsp_non_fhir_blob_container_client = blob_service_client.get_container_client(container=cont_name)
    nonfhir_processing_blob_list = dsp_non_fhir_blob_container_client.list_blobs(
        name_starts_with="v1/2.16.840.1.113883.3.12345/non-fhir")
    for blob in nonfhir_processing_blob_list:
        print(bl_name)
        if str(bl_name) in str(blob.name):
            return True
    return False


def intake_scheduler(connection_str, cont_name):
    bl_name = file_name_3
    blob_service_client = BlobServiceClient.from_connection_string(connection_str)
    dsp_non_fhir_blob_container_client = blob_service_client.get_container_client(container=cont_name)
    nonfhir_processing_blob_list = dsp_non_fhir_blob_container_client.list_blobs(
        name_starts_with="v1/2.16.840.1.113883.3.12345/non-fhir")
    for blob in nonfhir_processing_blob_list:
        print(bl_name)
        if str(bl_name) in str(blob.name):
            return True
    return False
