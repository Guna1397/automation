import os, sys
from tabulate import tabulate


def generate_appgtwy_html_report():
    output_dir_files = os.listdir('./')
    appgtwy_output_file = ""
    result = ""
    table = [["App Gtwy Output"]]
    for file in output_dir_files:
        if 'appgtwy_output' in file:
            appgtwy_output_file = file
        if appgtwy_output_file:
            break
    if not appgtwy_output_file:
        return "APP GATEWAY OUTPUT FILE NOT FOUND"
    with open(appgtwy_output_file, 'rb') as file:
        for cnt, line in enumerate(file):
            line_value = line.decode("utf-8")
            if "exist" in line_value:
                table.append([line_value.strip('\r\n')])
            if "FAIL" in line_value:
                result = "App Gtwy Configuration Test Failed"
            else:
                result = "App Gtwy Configuration Test Passed"
    f = open("appgtwy_output.html", "w+")
    f.write(tabulate(table, tablefmt="html"))
    return result

if __name__ == '__main__':
    print(generate_appgtwy_html_report())