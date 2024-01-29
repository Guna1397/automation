import time
from behave import  *
from selenium import  webdriver
from selenium.webdriver.common.by import By


# id = context.driver.session_id
# print(id)


@given('Launch')
def login(context):
    context.driver = webdriver.Chrome()
    context.driver.get("https://opensource-demo.orangehrmlive.com/")
    time.sleep(3)

@when('Login with "{user}" and "{password}"')
def password(context,password,user):
    context.driver.find_element(By.XPATH, "//*[@name='username']").send_keys(user)
    context.driver.find_element(By.XPATH,"//*[@name='password']").send_keys(password)


@when("login")
def loggedin(context):
    context.driver.find_element(By.XPATH, "//*[@type='submit']").click()
    time.sleep(5)

@then("Verify Logo")
def logo(context):
    try:
        text = context.driver.find_element(By.XPATH,"//*[@class='oxd-text oxd-text--h6 oxd-topbar-header-breadcrumb-module']").text
    except:
    # time.sleep(5)
        context.driver.close()
        assert False,"Test Failed"

    if text == "Dashboard":
        context.driver.close()
        assert True,"Test passed"
