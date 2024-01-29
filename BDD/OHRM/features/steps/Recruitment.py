import json
import time

from behave import *
from selenium import webdriver
from selenium.webdriver.common.by import By

# with open("../Configuration/config.json" , "r" ) as file :
#     data = json.load(file)

with open("../Configuration/config.json" , "r") as file:
    value = json.load(file)

@given("User login with credentials")
def login(context):
    context.driver = webdriver.Chrome()
    context.driver.get("https://opensource-demo.orangehrmlive.com/")
    context.driver.maximize_window()
    time.sleep(5)
    context.driver.find_element(By.XPATH, "//*[@name='username']").send_keys("Admin")
    context.driver.find_element(By.XPATH, "//*[@name='password']").send_keys("admin123")
    context.driver.find_element(By.XPATH, "//*[@type='submit']").click()
    time.sleep(3)

@when("User clicks recruitment tab")
def click_recruitment(context):
    # pass
    context.driver.find_element(By.XPATH,"//span[text()='Recruitment']").click()
    time.sleep(5)


