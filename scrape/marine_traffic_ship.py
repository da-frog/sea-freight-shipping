import csv
import time
from itertools import islice

from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


def get_soup_using_selenium(url: str, timeout: int = 10, driver=None) -> BeautifulSoup:
    if driver is None:
        driver = webdriver.Chrome('C:\\App\\bin\\chromedriver.exe')
        driver.get(url)
        WebDriverWait(driver, timeout)
        soup = BeautifulSoup(driver.page_source, 'html.parser')
        driver.quit()
    else:
        driver.get(url)
        WebDriverWait(driver, timeout)
        soup = BeautifulSoup(driver.page_source, 'html.parser')
    return soup


def get_speeds(driver: webdriver.Chrome) -> str:
    query = 'Speed recorded (Max / Average): '
    WebDriverWait(driver, 15).until(EC.presence_of_element_located((By.CSS_SELECTOR, 'div.MuiTypography-root.MuiTypography-body1.MuiTypography-gutterBottom')))
    for elem in driver.find_elements_by_css_selector('div.MuiTypography-root.MuiTypography-body1.MuiTypography-gutterBottom'):
        if elem.get_attribute('innerHTML').startswith(query):
            return elem.find_element_by_tag_name('b').get_attribute('innerHTML')
    raise ValueError('Text not found')


def separate_speeds(s: str) -> (str, str):
    max, avg = s.split(' / ')
    return max.split(' ')[0], avg.split(' ')[0]


def search_imo_number(driver: webdriver.Chrome, imo_number: str):
    driver.get(f'https://www.marinetraffic.com/en/ais/index/search/all?keyword={imo_number}')
    # get imo number once searched
    a = WebDriverWait(driver, 15).until(EC.presence_of_element_located((By.XPATH, "//a[@class='search_index_link']"))).get_attribute('href')
    return a


def get_ship_speeds_by_imo_number(driver: webdriver.Chrome, imo_number: str) -> (str, str):
    link = search_imo_number(driver, imo_number)
    driver.get(link)
    speeds = get_speeds(driver)
    max, avg = separate_speeds(speeds)
    return max, avg


if __name__ == '__main__':
    driver = webdriver.Chrome('C:\\App\\bin\\chromedriver.exe')
    print(get_ship_speeds_by_imo_number(driver, '9769300'))
    print(get_ship_speeds_by_imo_number(driver, '9806873'))
