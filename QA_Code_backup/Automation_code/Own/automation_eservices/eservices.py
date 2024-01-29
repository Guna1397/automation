import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions
from selenium.webdriver.support.wait import WebDriverWait
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
import json




def startBot():
    options = webdriver.ChromeOptions()
    options.add_argument('--headless')
    driver = webdriver.Chrome(ChromeDriverManager().install())
    driver.get("https://eservices.tn.gov.in/eservicesnew/land/chittaCheckNewRural_en.html?lan=en")
    driver.maximize_window()
    dis = driver.find_element(By.XPATH, "//select[@name='districtCode']").text
    Details = {}
    District_values = dis.split("t--")[1].split("\n")[1:]
    for i in District_values[0:2]:
        driver.find_element(By.XPATH, "//select[@name='districtCode']").send_keys(i)
        time.sleep(3)
        taluk = driver.find_element(By.XPATH, "//select[@name='talukCode']").text
        Taluk_values = taluk.split("k--")[1].split("\n")[1:]
        Taluk_dict = {}
        taluk_list = []
        for j in Taluk_values:
            driver.find_element(By.XPATH, "//select[@name='talukCode']").send_keys(j)
            time.sleep(3)
            village = driver.find_element(By.XPATH, "//select[@name='villageCode']").text
            Village_values = village.split("e--")[1].split("\n")[1:]
            Taluk_dict.update({j:Village_values})
        taluk_list.append(Taluk_dict)
        Details.update({i:taluk_list})
    json_object = json.dumps(Details, indent=2)
    with open("district_details.json", "w") as outfile:
        outfile.write(json_object)
    print("Successfully fetched details")
startBot()
