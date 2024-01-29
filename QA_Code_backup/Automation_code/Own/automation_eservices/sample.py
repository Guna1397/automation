import time

from selenium.webdriver.common import keys
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager




def googlesearch():
    options = webdriver.ChromeOptions()
    options.add_argument('--headless')
    driver = webdriver.Chrome(ChromeDriverManager().install())
    driver.get("https://www.google.com/")
    driver.maximize_window()
    driver.find_element(By.XPATH, "//textarea[@id='APjFqb']").send_keys("Sanjay Adhithya")
    driver.find_element(By.XPATH, "//textarea[@id='APjFqb']").send_keys(keys)
    time.sleep(5)
    print("Successfully opened browser")
googlesearch()
