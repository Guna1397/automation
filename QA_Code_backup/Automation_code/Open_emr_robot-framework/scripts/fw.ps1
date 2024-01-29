az login --service-principal --username a8fe6152-c33e-40d8-8ece-96954587ab40 --password 6c27gRG2nn0.EpLFsz0_h.n.~GvHN~q1C2 --tenant 6103a105-4013-4e17-8122-966437977bfd
az account set --subscription 79ebff4f-cfe7-4146-a0d6-5a60e76663f0
az config set extension.use_dynamic_install=yes_without_prompt
$fw_object = az network firewall nat-rule list -c DS-QA-NAT -f DS-QA-PRM-FW -g NA-DS-QA-NWK-SH -o json | Out-String | ConvertFrom-Json
foreach ($rule in $fw_object.rules)
{
    "Rule Name:" >> fw_rules_data.txt
    $rule.name >> fw_rules_data.txt
    "Destination Addresses:" >> fw_rules_data.txt
    $rule.destinationAddresses >> fw_rules_data.txt
    "Source Addresses:" >> fw_rules_data.txt
    $rule.sourceAddresses >> fw_rules_data.txt
    " " >> fw_rules_data.txt
    " " >> fw_rules_data.txt
}
