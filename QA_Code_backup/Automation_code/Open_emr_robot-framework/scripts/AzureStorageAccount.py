from azure.core.exceptions import ResourceExistsError
from azure.storage.blob import BlobServiceClient
import os


def batch_delete_blobs_sample(conn_string, container_name):
    # Set the connection string and container name values to initialize the Container Client
    connection_string = conn_string

    blob_service_client = BlobServiceClient.from_connection_string(conn_str=connection_string)
    # Create a ContainerClient to use the batch_delete function on a Blob Container
    container_client = blob_service_client.get_container_client(container_name)

    # List blobs in storage account
    blob_list = [b.name for b in list(container_client.list_blobs())]

    # Delete blobs
    # container_client.delete_blobs(*blob_list)

    if len(blob_list) <= 256:
        container_client.delete_blobs(*blob_list)

    else:
        start=0
        end=256

        while end<=len(blob_list):
             #each time, delete 256 blobs at most
             container_client.delete_blobs(*blob_list[start:end])
             start = start + 256
             end = end + 256

             if start < len(blob_list) and end > len(blob_list):
                container_client.delete_blobs(*blob_list[start:len(blob_list)])

if __name__ == '__main__':
    batch_delete_blobs_sample()

