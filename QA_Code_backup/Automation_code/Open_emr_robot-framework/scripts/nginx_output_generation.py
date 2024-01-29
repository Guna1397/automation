import os, sys
from tabulate import tabulate


def generate_nginx_html_report():
    output_dir_files = os.listdir('./')
    nginx_output_file = ""
    result = ""
    table = [["Nginx Output"]]
    for file in output_dir_files:
        if 'nginx_output' in file:
            nginx_output_file = file
        if nginx_output_file:
            break
    if not nginx_output_file:
        return "Nginx OUTPUT FILE NOT FOUND"
    with open(nginx_output_file, 'rb') as file:
        for cnt, line in enumerate(file):
            line_value = line.decode("utf-8")
            if "cluster" in line_value:
                table.append([line_value.strip('\r\n')])
            if "PASS" in line_value:
                result = "Nginx Configuration Test Passed"
            else:
                result = "Nginx Configuration Test Failed"
    f = open("nginx_output.html", "w+")
    f.write(tabulate(table, tablefmt="html"))
    return result

if __name__ == '__main__':
    print(generate_nginx_html_report())