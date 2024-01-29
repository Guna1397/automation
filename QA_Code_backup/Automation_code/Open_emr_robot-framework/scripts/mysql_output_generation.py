import os, sys
from tabulate import tabulate


def generate_mysql_html_report():
    output_dir_files = os.listdir('./')
    mysql_output_file = ""
    result = ""
    table = [["MySQL Output"]]
    for file in output_dir_files:
        if 'MySQL_Output' in file:
            mysql_output_file = file
        if mysql_output_file:
            break
    if not mysql_output_file:
        return "MYSQL OUTPUT FILE NOT FOUND"
    with open(mysql_output_file, 'rb') as file:
        for cnt, line in enumerate(file):
            line_value = line.decode("utf-8")
            if "Validation" in line_value:
                table.append([line_value.strip('\r\n')])
            if "PASS" in line_value:
                result = "MySQL Configuration Test Passed"
            elif "FAIL" in line_value:
                result = "MySQL Configuration Test Failed"
                return result
    f = open("mysql_output.html", "w+")
    f.write(tabulate(table, tablefmt="html"))
    return result

if __name__ == '__main__':
    print(generate_mysql_html_report())