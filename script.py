import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions
from selenium.webdriver.support.wait import WebDriverWait


def startBot():
    path = "E:\\User2\\chromedriver-win64\\chromedriver"
    driver = webdriver.Chrome(path)
    driver.get("https://pro-man.onrender.com/")
    driver.maximize_window()
    driver.find_element(By.XPATH, "//input[@type='text']").send_keys("one")
    driver.find_element(By.XPATH, "//input[@type='password']").send_keys("one")
    driver.find_element(By.XPATH, "//button[@type='button']").click()
    print("Successfully logged in")
    # time.sleep(10)
    wait = WebDriverWait(driver, 10)
    login = wait.until(expected_conditions.visibility_of_element_located((By.XPATH, "//div[2]/button")))
    login.click()
    time.sleep(5)
    print("Successfully logged out")
startBot()
