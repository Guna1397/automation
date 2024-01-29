import os
from tabulate import tabulate


def generate_namespace_html_report():
    # os.chdir("../infra_validation/Results")
    # output_dir = "./"
    # output_dir_files = os.listdir(output_dir)
    output_dir_files = os.listdir('./')
    namespace_output_file = ""
    result = ""
    table = [["Namespace Output"]]
    for file in output_dir_files:
        if 'namespace_output' in file:
            namespace_output_file = file
        if namespace_output_file:
            break
    if not namespace_output_file:
        return "NAMESPACE OUTPUT FILE NOT FOUND"
    with open(namespace_output_file, 'rb') as file:
        for cnt, line in enumerate(file):
            line_value = line.decode("utf-8")
            if "exists" in line_value:
                table.append([line_value.strip('\r\n')])
            if "PASS" in line_value:
                result = "Namespace Configuration Test Passed"
            else:
                result = "Namespace Configuration Test Failed"
    f = open("aks_namespaces.html", "w+")
    f.write(tabulate(table, tablefmt="html"))
    return result

if __name__ == '__main__':
    print(generate_namespace_html_report())