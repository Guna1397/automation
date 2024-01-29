import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

url = "https://mathup.com/games/crossbit"
driver = webdriver.Chrome()
driver.get(url)
driver.maximize_window()
time.sleep(3)
new = []
for i in range(10):
    start_time = time.time()
    driver.find_element(By.XPATH, "(//div[text()='Play'])[1]").click()
    try:
      myElem = WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.XPATH, "//p[text()='Make']")))
      print("page is loaded")
    except:
        print("page is not loaded")
    end_time = time.time()
    loading_time = end_time - start_time
    new.append(loading_time)
    print(f"The loading time for mathup website {url} {loading_time} is  seconds.")
    driver.refresh()
# print(new)
average = sum(new) / len(new)
print(f"The average time taken to load mathup page is {average}")




