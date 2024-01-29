import os, sys
from tabulate import tabulate


def generate_fw_html_report():
    fw_output_dir = "./pws_fw_dir"
    output_dir_files = os.listdir(fw_output_dir)
    fw_output_file = ""
    result = ""
    table = [["Firewall Rules Details:"]]
    table.append([" "])
    table.append([" "])
    for file in output_dir_files:
        if "fw_rules_data.txt" in file:
            fw_output_file = file
        if fw_output_file:
            break
    if not fw_output_file:
        return "FW OUTPUT FILE NOT FOUND"
    with open(os.path.join(fw_output_dir, fw_output_file), 'rb') as file:
        for cnt, line in enumerate(file):
            line_value = line.decode("utf-8")
            table.append([line_value.strip('\r\n')])
    f = open("fw_output.html", "w+")
    f.write(tabulate(table, tablefmt="html"))
    result = "Successfully Captured Firewall Rules Details"
    return result

if __name__ == '__main__':
    print(generate_fw_html_report())