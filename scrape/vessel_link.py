from bs4 import BeautifulSoup
from selenium import webdriver


def get_page(idx: int) -> str:
    if idx == 1:
        return ""
    else:
        return f"?page={idx}"


def find_link(page):
    browser = webdriver.Chrome(executable_path=r'C:\Users\User\Desktop\Driver\chromedriver.exe')
    i = 1
    text = open("Ship_link.txt", "w")
    while i <= page:
        browser.get('https://www.vesselfinder.com/vessels' + get_page(i))
        soup = BeautifulSoup(browser.page_source, "html.parser")
        answer = soup.find_all("a", {"class": "ship-link"})
        for a in answer:
            text.write("https://www.vesselfinder.com" + a["href"] + "\n")
        i += 1


find_link(60)