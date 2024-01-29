$DFLJSON = Get-Content ..\..\dsp-terratest-v0_2_0\deployment\qa\adv-infra\qa\configuration-files\aks-airflow-qa.json | Out-String | ConvertFrom-Json
$FHRJSON = Get-Content ..\..\dsp-terratest-v0_2_0\deployment\qa\adv-infra\qa\configuration-files\aks-fhr-qa.json | Out-String | ConvertFrom-Json
$QAJSON = Get-Content ..\..\dsp-terratest-v0_2_0\deployment\qa\adv-infra\qa\configuration-files\aks-microservices-qa.json | Out-String | ConvertFrom-Json
Set-Variable -Name "AKSDFLRG" -Value $DFLJSON.resource_group
Set-Variable -Name "AKSDFLName" -Value $DFLJSON.name
Set-Variable -Name "AKSFHRRG" -Value $FHRJSON.resource_group
Set-Variable -Name "AKSFHRName" -Value $FHRJSON.name
Set-Variable -Name "AKSQARG" -Value $QAJSON.resource_group
Set-Variable -Name "AKSQAName" -Value $QAJSON.name
Set-Variable -Name "QASubID" -Value $QAJSON.subscription_id

az login --service-principal --username a8fe6152-c33e-40d8-8ece-96954587ab40 --password 6c27gRG2nn0.EpLFsz0_h.n.~GvHN~q1C2 --tenant 6103a105-4013-4e17-8122-966437977bfd
az account set --subscription $QASubID
az aks get-credentials --resource-group $AKSDFLRG --name $AKSDFLName --admin
kubectl get namespaces -o json  >> ./aks_airflow_namespaces
az aks get-credentials --resource-group $AKSFHRRG --name $AKSFHRName --admin
kubectl get namespaces -o json >> ./aks_fhr_namespaces
az aks get-credentials --resource-group $AKSQARG --name $AKSQAName --admin
kubectl get namespaces -o json >> ./aks_microservices_namespaces