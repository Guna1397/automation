import sys
import json
from pprint import pprint
from azure.storage.blob import BlobServiceClient, BlobClient
from azure.storage.blob import ContentSettings, ContainerClient

env = sys.argv


def jsoner(env1):
    import json
    with open(r'../dsp_daa_fhir_layering/configurationfiles/'+env1+'/testdata/us_east/s3_input.json') as fd:
        json_data = json.load(fd)
    return json_data




def infra_jsoner(env1):
    import json

    with open(r'../dsp_daa_fhir_layering/configurationfiles/'+env1+'/testdata/us_east/infra_parameter_input.json') as fd:
        json_data = json.load(fd)
    return json_data


def check_dsep_val(sonj):

    for i in range(len(sonj['identifier'])):
        for k,v in sonj['identifier'][i]['assigner'].items():
            if v == "DSEP":
                return v


def check_dsep_uuid(sonj):
    for i in range(len(sonj['identifier'])):
        for k,v in sonj['identifier'][i]['assigner'].items():
            if v == 'DSEP':
                value_uuid=sonj['identifier'][i]['value']
                return value_uuid


def s3_lastest(key, secret_key, bucket_name):
    import boto3
    s3 = boto3.resource(
        service_name='s3',
        region_name='us-east-2',
        aws_access_key_id=key,
        aws_secret_access_key=secret_key
    )
    my_bucket = s3.Bucket(bucket_name)
    files = my_bucket.objects.filter()
    files = [obj.key for obj in sorted(files, key=lambda x: x.last_modified,
    reverse=True)]
    last = files[0][:-5]
    last = last.split('_')
    return last[1]

def id_jsoner(env1):
    import json

    with open(r'../dsp_daa_fhir_layering/configurationfiles/'+env1+'/testdata/us_east/id_input.json') as fd:
        json_data = json.load(fd)
    return json_data

def check_velys_resources(sonj):
    output_list = [x['resource'] for x in sonj['blob_name']]
    return output_list

def param_delta_update(env1):
    import json

    with open(r'../dsp_daa_fhir_layering/configurationfiles/'+env1+'/API/delta_update.json') as fd:
        json_data = json.load(fd)
    return json_data

def param_partner_sync(env1):
    import json
    with open(r'../dsp_daa_fhir_layering/configurationfiles/'+env1+'/API/s3_partner_sync.json') as fd:
        json_data = json.load(fd)
    return json_data

def param_daily(env1):
    import json

    with open(r'../dsp_daa_fhir_layering/configurationfiles/'+env1+'/API/daily_test.json') as fd:
        json_data = json.load(fd)
    return json_data

def param_mrn_search(env1):
    import json

    with open(r'../dsp_daa_fhir_layering/configurationfiles/'+env1+'/API/mrn_search.json') as fd:
        json_data = json.load(fd)
    return json_data

def fhir_param_jsoner(env):

    # Considering "json_list.json" is a json file

    with open(r'../dsp_daa_fhir_layering/configurationfiles/'+env+'/API/FHIR_patient_urls.json') as fd:
        json_data = json.load(fd)
    return json_data


def param_nonfhir(env1):
    import json

    with open(r'../dsp_daa_fhir_layering/configurationfiles/'+env1+'/API/non_fhir.json') as fd:
        json_data = json.load(fd)
    return json_data

def check_list(connection_str, cont_name,file_name):
    bl_name = file_name
    blob_service_client = BlobServiceClient.from_connection_string(connection_str)
    dsp_non_fhir_blob_container_client = blob_service_client.get_container_client(container=cont_name)
    nonfhir_processing_blob_list = dsp_non_fhir_blob_container_client.list_blobs()
    #print(nonfhir_processing_blob_list)
    for blob in nonfhir_processing_blob_list:
        print(bl_name)
        if str(bl_name) in str(blob.name):
            return True
    return False

def fhir_patient_jsoner(env, path):
    import json
    from pprint import pprint

    # Considering "json_list.json" is a json file

    with open(r'../dsp_daa_fhir_layering/configurationfiles/'+env+'/API/{}'.format(path)) as fd:
        json_data = json.load(fd)
    return json_data


def fhir_resource_jsoner(env, a):
    import json
    import re
    delimiters = "?id=", "&"
    regexPattern = '|'.join(map(re.escape, delimiters))
    # with open(r'../dsp_daa_fhir_layering/configurationfiles/'+env+'/API/{}'.format(path)) as fd:
    json_data = a
    resource = json_data["entry"][0]['request']['resource']
    resource = re.split(regexPattern, resource)
    type_resource = []
    resource_id = []
    for i in range(len(resource)):
        if resource[i].isalpha():
            type_resource.append(resource[i])
        elif resource[i].isdigit():
            resource_id.append(resource[i])
    response = [type_resource, resource_id]
    return response

def check_fhir_oid(sonj):
    for i in range(len(sonj['entry'])):
        for k, v in sonj["entry"][i]["resource"].items():
            if k == "identifier":
                for j in range(len(sonj["entry"][i]["resource"]["identifier"])):
                    for p, q in sonj["entry"][i]["resource"]["identifier"][j].items():
                        # print(q)
                        if q == "OID_for_DocSpera":
                            value_oid = sonj["entry"][i]["resource"]["identifier"][j]["value"]
                            value_oid = value_oid.split(':')
                            # print(value_uuid)
                            return value_oid[2]

def fhir_id_jsoner(path):
    import json
    import re
    delimiters = "?id=", "&"
    regexPattern = '|'.join(map(re.escape, delimiters))
    from pprint import pprint

    # Considering "json_list.json" is a json file

    with open(path) as fd:
        json_data = json.load(fd)
        resource = json_data["entry"][0]['request']['resource']
        resource = re.split(regexPattern, resource)
        print(resource)
    return resource


def fhir_id_comaprsion(sonj, a):
    for i in range(len(sonj['entry'])):
        for k, v in sonj["entry"][i]["resource"].items():
            # value = str(v)
            # value = value.lower()
            if (k == "id") and (v == a):
                return v

def fhir_resource_comaprision(sonj, a):
    for i in range(len(sonj['entry'])):
        for k, v in sonj["entry"][i]["resource"].items():
            value = str(v)
            value = value.lower()
            if (k == "resourceType") and (value == a):
                return value



def s3_check_dsep_val(sonj):
    for i in range(len(sonj['identifier'])):
        for k, v in sonj['identifier'][i].items():
            if v == 'DSEP':
                return v


def s3_check_dsep_uuid(sonj):
    for i in range(len(sonj['identifier'])):
        for k, v in sonj['identifier'][i].items():
            if v == 'DSEP_Patient_ID':
                value_uuid = sonj['identifier'][i]['value']
                return value_uuid

def s3_check_oid(sonj):
    for i in range(len(sonj['identifier'])):
        for k, v in sonj['identifier'][i].items():
            if v == 'OID_for_DocSpera':
                value_oid = sonj['identifier'][i]['value']
                return value_oid
def epoch_converter(a):
    from datetime import datetime
    ts = int(a)

    # if you encounter a "year is out of range" error the timestamp
    # may be in milliseconds, try `ts /= 1000` in that case
    return datetime.utcfromtimestamp(ts).strftime('%Y-%m-%d %H:%M:%S')

# def json_Download():
#     STORAGEACCOUNTURL = "https://nadsiadlvelysdl.blob.core.windows.net"
#     STORAGEACCOUNTKEY = "9D+svH1tspqNBNYyFmKbBI36xFbR+JSB25/iBEOVtN2x8mNu/G3/TZ2f0oHfaHmths2LrAcNNZVk++kfSasr7A=="
#     CONTAINERNAME = "docspera-ack"
#     BLOBNAME = "9f801853-50ee-4195-9396-a39b6cc31956-ACK.json"
#     blob_service_client_instance = BlobServiceClient(
#     account_url=STORAGEACCOUNTURL, credential=STORAGEACCOUNTKEY)
#     blob_client_instance = blob_service_client_instance.get_blob_client(
#     CONTAINERNAME, BLOBNAME, snapshot=None)
#     blob_data = blob_client_instance.download_blob()
#     data = blob_data.readall()
#     print(data)
#     return data

def json_Download(account_url,account_key,container,blobname):
    STORAGEACCOUNTURL = account_url
    STORAGEACCOUNTKEY = account_key
    CONTAINERNAME = container
    BLOBNAME = blobname
    blob_service_client_instance = BlobServiceClient(
    account_url=STORAGEACCOUNTURL, credential=STORAGEACCOUNTKEY)
    blob_client_instance = blob_service_client_instance.get_blob_client(
    CONTAINERNAME, BLOBNAME, snapshot=None)
    blob_data = blob_client_instance.download_blob()
    data = blob_data.readall()
    print(data)
    return data

def param_docspera_ext(env1):
    import json

    with open(r'../dsp_daa_fhir_layering/configurationfiles/'+env1+'/API/docspera_external.json') as fd:
        json_data = json.load(fd)
    return json_data
def sas_splitter(env1,sas):
    token = sas.split("&")
    token_details = {i.split('=')[0]: (i.split('=')[1]) for i in token}
    return token_details

if __name__=="__main__":
    print()
    json_Download()