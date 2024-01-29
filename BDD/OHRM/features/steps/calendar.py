import time
from behave import  *
from selenium import  webdriver
from selenium.webdriver.common.by import By


# id = context.driver.session_id
# print(id)


@given('User login with credential')
def login(context):
    # context.driver = webdriver.Chrome()
    # context.driver.get("www.youtube.com")
    # time.sleep(3)
    driver = webdriver.Chrome()
    driver.get("https://opensource-demo.orangehrmlive.com/web/index.php/auth/login")
    print("Page Title:", driver.title)
    driver.quit()

