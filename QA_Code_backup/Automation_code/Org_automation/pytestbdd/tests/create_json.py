# All contents © Medical Devices Business Services, Inc. 2023. All Rights Reserved.
# pylint: skip-file
# import variables
import base64
# import json
# import os
import time
from custom_logger import *
get_cwd = "../../../../"
import platform
running_platform = platform.system()
def createjson(scenario_name,evidence):
    # if running_platform == "Linux":
    #     variables.load_env(f"{envpath}")
    # elif running_platform == "Windows":
    #     variables.load_env(f"{get_cwd}{envpath}")
    #
    # with open(logpath, "r") as log_file:
    #     agent_log_content = log_file.read()
    #
    # agent_log_base64 = base64.b64encode(agent_log_content.encode("utf-8")).decode("utf-8")
    #
    all_data = {}
    name = {}
    step_dict = {}
    #
    # agent_log_data = [
    #     {
    #         "data": agent_log_base64,
    #         "filename": "agent_log.txt",
    #         "contentType": "text/plain"
    #     }
    # ]

    with open(evidence + ".txt", "r") as f:
        i = 1
        for line in f:
            if "Name:" in line:
                name_line = line.strip()
                name[i] = name_line.replace("Name:", "")
                i = i + 1

    with open(evidence + ".txt", "r") as f:
        content = f.read()

    test_case_count = 0
    step_count = 0
    for i, step_content in enumerate(content.split("Adding providers")[1:], start=1):
        search_word = "Step:1"
        if search_word in step_content:

            step_dict = {}
            test_id = test_case_count + 1
            step_count = 1
            test_case_count = test_id
        else:
            step_count = step_count + 1

        step_data = [{
            "data":
                base64.b64encode("Adding providers".encode("utf-8") + step_content.encode("utf-8")).decode("utf-8"),
            "filename": f"Step{step_count}.txt",
            "contentType": "text/plain",
        }]

        # step_dict["agent_log_data"] = agent_log_data

        step_dict[f"Step{step_count}"] = step_data
        all_data[f"{scenario_name}"] = step_dict

    with open(evidence + '.json', 'r') as f:
        my_data = json.load(f)
    my_data.update(all_data)

    with open(evidence + '.json', 'w') as f:
        json.dump(my_data, f, indent=4)

    file_handler.close()
    time.sleep(10)
    os.remove(evidence + ".txt")