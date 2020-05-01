from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait


url = 'https://www.vesselfinder.com/vessels/PRELUDE-IMO-9648714-MMSI-503000101'


def get_soup_using_selenium(url: str, timeout: int = 10) -> BeautifulSoup:
    driver = webdriver.Chrome('C:\\App\\bin\\chromedriver.exe')
    driver.get(url)
    WebDriverWait(driver, timeout)
    soup = BeautifulSoup(driver.page_source, 'html.parser')
    driver.quit()
    return soup


def is_imo_number(imo_number: str) -> bool:
    try:
        imo_number = str(imo_number)
        assert len(imo_number) == 7
        sum_ = 0
        for i, c in enumerate(imo_number[:6]):
            sum_ += int(c) * (7 - i)
        assert int(imo_number[6]) == sum_
    except AssertionError:
        return False
    return True


def get_imo_number(soup: BeautifulSoup) -> str:
    imo_number = soup.find(string='IMO number').parent.next_sibling.string
    assert is_imo_number(imo_number)
    return str(imo_number)


def get_vessel_particulars(soup: BeautifulSoup):
    minsoup = soup.find(string='Vessel Particulars').parent.next_sibling
    imo_number = get_imo_number(minsoup)
