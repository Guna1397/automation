import json
import time
import webdrivermanager
from selenium import webdriver
from behave import *
from selenium.webdriver.common.by import By
from webdriver_manager.chrome import ChromeDriverManager
import random
import string
from datetime import datetime


def generate_username(prefix, length=5):
    global username,unique_username
    # Combine the prefix with a random string
    random_suffix = ''.join(random.choices(string.ascii_lowercase + string.digits, k=length))
    username = f"{prefix}_{random_suffix}"
    return username


prefix = "user"
unique_username = generate_username(prefix)
print(unique_username)


current_datetime = datetime.now().strftime("%Y-%m-%d %H-%M-%S")
str_current_datetime = str(current_datetime)
file_name = str_current_datetime+".png"



with open("../Demo_sites/Configuration/config.json" , "r+") as f:
    data = json.load(f)
    data['username'] = unique_username
    f.close()

def register_users(self):
    self.driver = webdriver.Chrome(ChromeDriverManager().install())
    self.driver.get(data["url"])
    self.driver.maximize_window()
    self.driver.find_element(By.XPATH,"//a[contains(text(),'Register')]").click()
    self.driver.save_screenshot("register_"+datetime.now().strftime("%Y-%m-%d %H-%M-%S")+".png")
    self.driver.get_screenshot_as_png()
    # time.sleep(5)


def enter_details(self):
    self.driver.find_element(By.XPATH, "//input[@id='customer.firstName']").send_keys(data["fname"])
    self.driver.find_element(By.XPATH, "//input[@id='customer.lastName']").send_keys(data["lname"])
    self.driver.find_element(By.XPATH, "//input[@id='customer.address.street']").send_keys(data["address"])
    self.driver.find_element(By.XPATH, "//input[@id='customer.address.city']").send_keys(data["city"])
    self.driver.find_element(By.XPATH, "//input[@id='customer.address.state']").send_keys(data["state"])
    self.driver.find_element(By.XPATH, "//input[@id='customer.address.zipCode']").send_keys(data["zip code"])
    self.driver.find_element(By.XPATH, "//input[@id='customer.ssn']").send_keys(data["ssn"])
    self.driver.find_element(By.XPATH, "//input[@id='customer.username']").send_keys(data['username'])
    self.driver.find_element(By.XPATH, "//input[@id='customer.password']").send_keys(data["password"])
    self.driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
    self.driver.find_element(By.XPATH, "//input[@id='repeatedPassword']").send_keys(data["password"])
    self.driver.find_element(By.XPATH,"(//input[@type='submit'])[2]").click()
    self.driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
    self.driver.save_screenshot("created_"+datetime.now().strftime("%Y-%m-%d %H-%M-%S")+".png")
    time.sleep(10)

