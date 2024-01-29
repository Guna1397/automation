import json
import os, sys
from tabulate import tabulate


def parse_aks_namespace_details():
    namespace_list = []
    aks_file = ""
    namespace_result = ""
    result = ""
    ps_namespace_output_dir = "./ps_namespace_dir"
    files_in_dir = os.listdir(ps_namespace_output_dir)
    for file in files_in_dir:
        if f'{sys.argv[1]}_namespaces' in file:
            aks_file = file
        if aks_file:
            break
    if not aks_file:
        result = "AKS File not Found"
        return result
    config_file_path = f"../infra_validation/deployment/npd/base-infra/shared/configuration-files/aks-{sys.argv[1]}.json"
    with open(os.path.join(ps_namespace_output_dir, aks_file), "rb") as file:
        content = json.load(file)
        for item in content["items"]:
            namespace_list.append(item["metadata"]["name"])
    with open(config_file_path, "rb") as config_file:
        config_content = json.load(config_file)
        aks_namespaces = config_content["namespaces"]
        aks_name = config_content["name"]
    for namespace in namespace_list:
        if namespace not in aks_namespaces:
            print(f'Namespace {namespace} is not listed in design')
            result = "Namespaces Validation Failed"
            namespace_result = f"AKS Secret Validation for {aks_name} (FAIL)"
    if not namespace_result:
        namespace_result = f"AKS Namespaces Validation for {aks_name} (PASS)"
    if "Failed" in result:
        result = "Namespaces Validation FAILED"
    else:
        result = "Namespaces Validation PASSED"
    table = [[namespace_result], ["Namespaces:"], [namespace_list], [" "]]
    f = open("aks_namespaces.html", "w+")
    f.write(tabulate(table, tablefmt='html'))
    return result

if __name__ == "__main__":
    print(parse_aks_namespace_details())
