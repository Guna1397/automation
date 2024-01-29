az login --service-principal --username a8fe6152-c33e-40d8-8ece-96954587ab40 --password 6c27gRG2nn0.EpLFsz0_h.n.~GvHN~q1C2 --tenant 6103a105-4013-4e17-8122-966437977bfd
az account set --subscription d12bc007-2c84-4c58-8afb-99e8e2ef5ffe
az aks get-credentials --resource-group NA-DS-NPD-AFL-SIT --name DS-NPD-AFL-SIT --admin
kubectl get namespaces -o json  >> ./aks_airflow_namespaces
#kubectl get secret -n airflow -o json  >> ./aks_airflow_secret
#kubectl get secret -n nifi -o json  >> ./aks_nifi_secret
az aks get-credentials --resource-group NA-DS-NPD-FHR-SIT --name DS-NPD-FHR-SIT --admin
kubectl get namespaces -o json >> ./aks_fhr_namespaces
kubectl get secret -n fhir -o json  >> ./aks_fhr_secret
az aks get-credentials --resource-group NA-DS-NPD-AKS-SIT --name DS-NPD-AKS-SIT --admin
kubectl get namespaces -o json >> ./aks_sit_namespaces
kubectl get secret -n sit-velys-insights -o json  >> ./aks_velys_insights_secret
kubectl get secret -n sit-velys-risk-score -o json  >> ./aks_fhr_insights_secret