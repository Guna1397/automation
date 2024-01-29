import os, sys
from tabulate import tabulate


def generate_acr_html_report():
    output_dir_files = os.listdir('./')
    aks_to_acr_file = ""
    result = ""
    table = [["ACR Output"]]
    for file in output_dir_files:
        if 'aks_to_acr' in file:
            aks_to_acr_file = file
        if aks_to_acr_file:
            break
    if not aks_to_acr_file:
        return "AKS TO ACR OUTPUT FILE NOT FOUND"
    with open(aks_to_acr_file, 'rb') as file:
        for cnt, line in enumerate(file):
            line_value = line.decode("utf-8")
            if "attached" in line_value:
                table.append([line_value.strip('\r\n')])
            if "PASS" in line_value:
                result = "ACR Configuration Test Passed"
            else:
                result = "ACR Configuration Test Failed"
    f = open("acr_output.html", "w+")
    f.write(tabulate(table, tablefmt="html"))
    return result

if __name__ == '__main__':
    print(generate_acr_html_report())