Write-Host 'Hello, World!'
az login --service-principal --username a8fe6152-c33e-40d8-8ece-96954587ab40 --password 6c27gRG2nn0.EpLFsz0_h.n.~GvHN~q1C2 --tenant 6103a105-4013-4e17-8122-966437977bfd
az account set --subscription d12bc007-2c84-4c58-8afb-99e8e2ef5ffe
az aks get-credentials --resource-group NA-DS-NPD-AKS-DEV --name DS-NPD-AKS-DEV --admin
kubectl get namespaces -o json  >> ./aks_services_namespaces
az aks get-credentials --resource-group na-ds-npd-dfl-sh --name DS-NPD-AFL --admin
kubectl get namespaces -o json >> ./aks_airflow_namespaces
az aks get-credentials --resource-group na-ds-npd-dfl-sh --name DS-NPD-NFI --admin
kubectl get namespaces -o json >> ./aks_nifi_namespaces
az aks get-credentials --resource-group na-ds-npd-fhr-dev --name DS-NPD-FHR-DEV --admin
kubectl get namespaces -o json >> ./aks_fhr_namespaces