# All contents © Medical Devices Business Services, Inc. 2023. All Rights Reserved.
import logging
import json
import os

logging.getLogger("azure.storage.common.storageclient").setLevel(logging.WARNING)
logging.getLogger('azure.core.pipeline.policies.http_logging_policy').setLevel(logging.WARNING)
logging.getLogger("urllib3").setLevel(logging.WARNING)


with open('evidence.json', 'w') as f:
    json.dump({},f)
# Create a file handler that writes logs to a JSON file
file_handler = logging.FileHandler('evidence.txt')
file_handler.setLevel(logging.DEBUG)
formatter = logging.Formatter('%(message)s')
file_handler.setFormatter( formatter)

# Add the file handler to the root logger
logging.getLogger().addHandler(file_handler)

# the name will be set for each test step in 'pytest_bdd_before_step'
logger = logging.getLogger("")