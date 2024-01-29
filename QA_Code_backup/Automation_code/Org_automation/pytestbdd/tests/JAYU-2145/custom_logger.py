import logging

logging.getLogger("azure.storage.common.storageclient").setLevel(logging.WARNING)
logging.getLogger('azure.core.pipeline.policies.http_logging_policy').setLevel(logging.WARNING)
logging.getLogger("urllib3").setLevel(logging.WARNING)
# the name will be set for each test step in 'pytest_bdd_before_step'
logger = logging.getLogger("")
