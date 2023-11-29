import json
import time
from multiprocessing import context

from prompt_toolkit.contrib.telnet.protocol import EC
from  selenium import webdriver
from behave import  *
from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait

with open("../Configuration/config.json" , "r") as file:
    value = json.load(file)

@given("User login with credential")
def userLogin(context):
    context.driver = webdriver.Chrome()
    context.driver.get(value["url"])
    context.driver.maximize_window()
    # wait = WebDriverWait(context.driver,5)
    time.sleep(5)
    context.driver.find_element(By.XPATH, "//*[@name='username']").send_keys("Admin")
    context.driver.find_element(By.XPATH, "//*[@name='password']").send_keys("admin123")
    context.driver.find_element(By.XPATH, "//*[@type='submit']").click()
    time.sleep(5)

@when("User rename the values")
def rename(context):
    context.driver.find_element(By.XPATH,"//span[text()='My Info']").click()
    time.sleep(4)
    context.driver.find_element(By.XPATH,"//*[@name='firstName']").send_keys("Guna")
    context.driver.find_element(By.XPATH, "//*[@name='lastName']").send_keys("Seelan")
    context.driver.find_element(By.XPATH, "(//input[@class='oxd-input oxd-input--active'])[3]").send_keys("007")
    context.driver.find_element(By.XPATH, "(//span[@class='oxd-radio-input oxd-radio-input--active --label-right oxd-radio-input'])[1]").click()
    time.sleep(5)

