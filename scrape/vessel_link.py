from bs4 import BeautifulSoup
from selenium import webdriver


def find_link(page):
    browser = webdriver.Chrome(executable_path=r'C:\Users\User\Desktop\Driver\chromedriver.exe')
    i = 1
    text = open("Ship_link.txt", "w")
    while i <= page:
        if i == 1:
            browser.get("https://www.vesselfinder.com/vessels")
            soup = BeautifulSoup(browser.page_source, "html.parser")
            answer = soup.find_all("a", {"class": "ship-link"})
            for a in answer:
                text.write("https://www.vesselfinder.com" + a["href"] + "\n")
            i += 1
        else:
            browser.get(f"https://www.vesselfinder.com/vessels?page={i}")
            soup = BeautifulSoup(browser.page_source, "html.parser")
            answer = soup.find_all("a", {"class": "ship-link"})
            for a in answer:
                text.write("https://www.vesselfinder.com" + a["href"] + "\n")
            i += 1


find_link(60)