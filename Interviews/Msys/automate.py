from selenium import webdriver
#
# driver = webdriver.Chrome
# driver.get("https://docs.pytest.org/en/7.1.x/how-to/fixtures.html")

# import requests
#
# res = requests.get("https://dummy.restapiexample.com/api/v1/employees")
# print(res.json())

def test_demofun():
    print("Msys technologies")
    driver = webdriver.Chrome()
    driver.get("https://docs.pytest.org/en/7.1.x/how-to/fixtures.html")
    driver.print_page()



