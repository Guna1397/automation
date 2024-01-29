"""A dummy docstring."""
import os
import ast
import json
import pymysql, logging
from dbutils.pooled_db import PooledDB
import base64
# import mysql.connector

print(os.getcwd())
with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]

db_details = os.environ['DB_DETAILS'].split(',')
pool_config = os.environ['POOLING_DETAILS'].split(',')

# cert = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURyekNDQXBlZ0F3SUJBZ0lRQ0R2Z1ZwQkNSckdoZFdySldaSEhTakFOQmdrcWhraUc5dzBCQVFVRkFEQmgKTVFzd0NRWURWUVFHRXdKVlV6RVZNQk1HQTFVRUNoTU1SR2xuYVVObGNuUWdTVzVqTVJrd0Z3WURWUVFMRXhCMwpkM2N1WkdsbmFXTmxjblF1WTI5dE1TQXdIZ1lEVlFRREV4ZEVhV2RwUTJWeWRDQkhiRzlpWVd3Z1VtOXZkQ0JEClFUQWVGdzB3TmpFeE1UQXdNREF3TURCYUZ3MHpNVEV4TVRBd01EQXdNREJhTUdFeEN6QUpCZ05WQkFZVEFsVlQKTVJVd0V3WURWUVFLRXd4RWFXZHBRMlZ5ZENCSmJtTXhHVEFYQmdOVkJBc1RFSGQzZHk1a2FXZHBZMlZ5ZEM1agpiMjB4SURBZUJnTlZCQU1URjBScFoybERaWEowSUVkc2IySmhiQ0JTYjI5MElFTkJNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUE0anZoRVhMZXFLVFRvMWVxVUtLUEMzZVF5YUtsN2hMT2xsc0IKQ1NETUFaT25UakMzVS9kRHhHa0FWNTNpalNMZGh3WkFBSUVKenM0Ymc3L2Z6VHR4UnVMV1pzY0ZzM1luRm85NwpuaDZWZmU2M1NLTUkydGF2ZWd3NUJtVi9TbDBmdkJmNHE3N3VLTmQwZjNwNG1WbUZhRzVjSXpKTHYwN0E2RnB0CjQzQy9keEMvL0FIMmhkbW9SQkJZTXFsMUdOWFJvcjVINGlkcTlKb3orRWtJWUl2VVg3UTZoTCtocWtwTWZUN1AKVDE5c2RsNmdTemVSbnR3aTVtM09GQnFPYXN2K3piTVVaQmZIV3ltZU1yL3k3dnJUQzBMVXE3ZEJNdG9NMU8vNApnZFc3alZnL3RSdm9TU2lpY05veEJOMzNzaGJ5VEFwT0I2anRTajFldFgramtNT3ZKd0lEQVFBQm8yTXdZVEFPCkJnTlZIUThCQWY4RUJBTUNBWVl3RHdZRFZSMFRBUUgvQkFVd0F3RUIvekFkQmdOVkhRNEVGZ1FVQTk1UU5WYlIKVEx0bThLUGlHeHZEbDdJOTBWVXdId1lEVlIwakJCZ3dGb0FVQTk1UU5WYlJUTHRtOEtQaUd4dkRsN0k5MFZVdwpEUVlKS29aSWh2Y05BUUVGQlFBRGdnRUJBTXVjTjZwSUV4SUsrdDFFbkU5U3NQVGZyZ1QxZVhrSW95UVkvRXNyCmhNQXR1ZFhIL3ZUQkgxakx1RzJjZW5Ubm1DbXJFYlhqY0tDaHpVeUltWk9Na1hEaXF3OGN2cE9wLzJQVjVBZGcKMDZPL25Wc0o4ZFdPNDFQMGptUDZQNmZidEdiZlltYlcwVzVCamZJdHRlcDNTcCtkV09JcldjQkFJKzB0S0lKRgpQbmxVa2lhWTRJQklxRGZ2OE5aNVlCYmVyT2dPelc2c1JCYzRMMG5hNFVVK0tyazJVODg2VUFiM0x1akVWMGxzCllTRVkxUVN0ZUR3c09vQnJwK3V2RlJUcDJJbkJ1VGhzNHBGc2l2OWt1WGNsVnpEQUd5U2o0ZHpwMzBkOHRiUWsKQ0FVdzdDMjlDNzlGdjFDNXFmUHJtQUVTcmNpSXhwZzBYNDBLUE1icDFaV1ZiZDQ9Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0="
# pem_path = "/tmp/DigiCertGlobalRootCA.crt.pem"
# decode_dtring = base64.b64decode(cert).decode("utf-8")
# with open(pem_path, "w", encoding="UTF-8") as file:
#     file.write(decode_dtring)
#     file.close()

# mydb = mysql.connector.connect(
#         host=db_details[0],
#         user=os.environ['DB_USER_NAME'],
#         password=os.environ['DB_PASSWORD'],
#         database=db_details[2]
#     )
# mycursor = mydb.cursor()

# mycursor.fetchall

MYSQL_CONFIG = {
    "host": db_details[0],
    "port": int(db_details[1]),
    "db": db_details[2],
    "password": os.environ['DB_PASSWORD'],
    "user": os.environ['DB_USER_NAME'],
    "charset": db_details[3],
    "cursorclass": pymysql.cursors.DictCursor,
    "autocommit": ast.literal_eval(db_details[4]),
    "ssl":{"fake_flag_to_enable_tls":True},
    # "ssl_ca": pem_path,
    # "ssl_verify_cert": True,
}

logging.info(os.environ['DB_PASSWORD'])

POOL_CONFIG = {
    # Modules using linked databases
    "creator": pymysql,
    "maxconnections": int(pool_config[0]),
    "mincached": int(pool_config[1]),
    "maxcached": int(pool_config[2]),
    "maxshared": int(pool_config[3]),
    "blocking": ast.literal_eval(pool_config[4]),
    "maxusage": ast.literal_eval(pool_config[5]),
    "setsession": [],
    "ping": int(pool_config[6]),
}

POOL = PooledDB(**MYSQL_CONFIG, **POOL_CONFIG)


class SqlPooled:
    """A dummy docstring."""
    def __init__(self):
        """A dummy docstring."""
        self._connection = POOL.connection()
        self._cursor = self._connection.cursor()

    def fetch_one(self, sql, args):
        """A dummy docstring."""
        self._cursor.execute(sql, args)
        result = self._cursor.fetchone()
        return result

    def fetch_all(self, sql, args):
        """A dummy docstring."""
        self._cursor.execute(sql, args)
        result = self._cursor.fetchall()
        return result

    def close(self):
        """A dummy docstring."""
        self._connection.close()

    def __del__(self):
        """A dummy docstring."""
        self._connection.close()
