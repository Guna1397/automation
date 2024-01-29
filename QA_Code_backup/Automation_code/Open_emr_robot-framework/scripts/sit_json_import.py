import sys

env = sys.argv


def jsoner(env1):
    import json

    with open(r'../dsp_daa_fhir_layering/configurationfiles/'+env1+'/testdata/us_east/s3_input.json') as fd:
        json_data = json.load(fd)
    return json_data


def id_jsoner():
    import json

    with open(r'../dsp_daa_fhir_layering/robot-framework/scripts/id_input.json') as fd:
        json_data = json.load(fd)
    return json_data


def param_jsoner(env1):
    import json

    with open(r'../dsp_daa_fhir_layering/configurationfiles/'+env1+'/testdata/us_east/parameter_input.json') as fd:
        json_data = json.load(fd)
    return json_data


def infra_jsoner(env1):
    import json

    with open(r'../dsp_daa_fhir_layering/configurationfiles/'+env1+'/testdata/us_east/infra_parameter_input.json') as fd:
        json_data = json.load(fd)
    return json_data



def check_dsep_val(sonj):
    for i in range(len(sonj['identifier'])):
        for k, v in sonj['identifier'][i]['assigner'].items():
            if v == "DSEP":
                return v


def check_dsep_uuid(sonj):
    for i in range(len(sonj['identifier'])):
        for k, v in sonj['identifier'][i].items():
            if v == 'DSEP_Patient_ID':
                value_uuid = sonj['identifier'][i]['value']
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


def sit_check_dsep_val(sonj):
    for i in range(len(sonj['identifier'])):
        for k, v in sonj['identifier'][i].items():
            if v == 'DSEP':
                return v


def sit_check_dsep_uuid(sonj):
    for i in range(len(sonj['identifier'])):
        for k, v in sonj['identifier'][i].items():
            if v == 'DSEP':
                value_uuid = sonj['identifier'][i]['value']
                return value_uuid


def sit_jsoner():
    import json

    with open(r'../dsp_daa_fhir_layering/robot-framework/scripts/sit_env_parameter_input.json') as fd:
        json_data = json.load(fd)
    return json_data