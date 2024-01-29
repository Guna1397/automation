import time

from selenium import webdriver
from selenium.webdriver.common.by import By

driver = webdriver.Chrome()
driver.get("https://mathup.com/games/crossbit")
driver.maximize_window()
time.sleep(3)
for i in range(10):
    driver.find_element(By.XPATH, "(//div[text()='Play'])[1]").click()
    time.sleep(3)
    level = driver.find_element(By.XPATH, "(//div[@class='GamePostStart_value__zH0b9'])[2]").text
    print(f"The Difficulty level is {level}")
    driver.refresh()
