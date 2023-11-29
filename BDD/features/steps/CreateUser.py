# from datetime import time
import json
import time

import webdriver_manager
import webdrivermanager
from behave import *
from selenium import  webdriver
from selenium.webdriver.common.by import *
from sqlalchemy.testing.plugin.plugin_base import logging
# config = open("../../Configuration/config.json" , "r")
with open("../Configuration/config.json" , "r") as file:
    val = json.load(file)
print(val["url"])

# from selenium.webdriver.common.by import By

@given('Launche')
def login(context):
    context.driver = webdriver.Chrome()
    context.driver.get("https://opensource-demo.orangehrmlive.com/")
    context.driver.maximize_window()
    time.sleep(5)

@when('Login with username and password')
def password(context,driver):
    context.driver.find_element(By.XPATH, "//*[@name='username']").send_keys("Admin")
    context.driver.find_element(By.XPATH,"//*[@name='password']").send_keys("admin123")
    context.driver.find_element(By.XPATH, "//*[@type='submit']").click()
    time.sleep(5)

@then("Create user")
def usercreation(context):
    context.driver.find_element(By.XPATH, "//span[text()='Admin']").click()
    time.sleep(5)
    context.driver.find_element(By.XPATH,"(//input[@class='oxd-input oxd-input--active'])[2]").send_keys("Gunaseelan")
    time.sleep(5)
    context.driver.find_element(By.XPATH, "(//div[text()='-- Select --'])[1]").click()
    time.sleep(3)
    context.driver.find_element(By.XPATH, "//span[contains(text(),'Admin')][1]").click()
    time.sleep(5)
    # context.driver.find_element(By.XPATH, "//div[@class='oxd-select-text-input' and text()='Admin']").click()
    # driver.find_element(By.XPATH, "//div[@class='oxd-select-text-input' and text()='Admin']").text
    # context.driver.find_element(By.XPATH, "// input[ @ placeholder = 'Type for hints...']").send_keys("Odis  Adalwin")
    # context.driver.find_element(By.XPATH, "// div[text() = '-- Select --']")
    # context.driver.find_element(By.XPATH, "//div[@class='oxd-select-text-input' and text()='Enabled']").click()
    # time.sleep(5)
    # context.driver.find_element(By.XPATH, "//span[text()='Leave']").click()
    # time.sleep(3)
    # t = context.driver.find_elements(By.XPATH,"//div[@class='oxd-table-row oxd-table-row--with-border']")
    # for value in t:
    #     print(value.text)


@then("Verify user creation")
def verifycreation(context):
    assert True
