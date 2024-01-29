# All contents © Medical Devices Business Services, Inc. 2023. All Rights Reserved.
# this is a function to add new parameters to pytest
import logging


def pytest_addoption(parser):
    parser.addoption(
        "--env", action="store", default="defaultParam", help="Environment path"
    )
    parser.addoption(
        "--evidencejson", action="store", default="", help="Evidence file name"
    )
    parser.addoption(
        "--device", action="store", default="defaultParam", help="Device create"
    )
    parser.addoption(
        "--device_type", action="store", default="defaultParam", help="Device type"
    )
    parser.addoption(
        "--environment", action="store", default="defaultParam", help="Environment set"
    )
    parser.addoption(
        "--username", action="store", default="", help="Set username"
    )
    parser.addoption(
        "--password", action="store", default="", help="Set password"
    )



# this method here makes your configuration global
option = None


def pytest_configure(config):
    global option
    option = config.option