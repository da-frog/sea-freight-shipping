import csv
import time
from itertools import islice

from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait


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


def is_imo_number(imo_number: str) -> bool:
    try:
        imo_number = str(imo_number)
        assert len(imo_number) == 7
        sum_ = 0
        for i, c in enumerate(imo_number[:6]):
            sum_ += int(c) * (7 - i)
        assert imo_number[6] == str(sum_)[-1]
    except AssertionError:
        return False
    return True


def get_imo_number(soup: BeautifulSoup) -> str:
    imo_number = soup.find(string='IMO number').parent.next_sibling.string
    assert is_imo_number(imo_number)
    return str(imo_number)


def get_vessel_particulars(soup: BeautifulSoup):
    minsoup = soup.find(string='Vessel Particulars').parent.parent.find(class_='tparams')
    dct = dict()

    for attr in (
            'IMO number',
            'Vessel Name',
            'Ship type',
            'Flag',
            'Gross Tonnage',
            'Summer Deadweight (t)',
            'Length Overall (m)',
            'Beam (m)',
            'Draught (m)',
            'Year of Built',
            'TEU',
            'Crude',
            'Grain',
            'Bale',
    ):
        value = str(minsoup.find(string=attr).parent.next_sibling.string)
        if value in ('-',):
            dct[attr] = None
        else:
            dct[attr] = value

    if not is_imo_number(dct['IMO number']):
        print('warning! not imo number: ', dct['IMO number'])
    return dct


def get_position_and_voyage_data(soup: BeautifulSoup):
    minsoup = soup.find(string='Position & Voyage Data').parent.parent.find(class_='tparams')
    dct = dict()

    for attr in (
            'AIS Type',
            'Flag',
            'Destination',
            'ETA',
            'IMO / MMSI',
            'Callsign',
            'Length / Beam',
            'Current draught',
            'Course / Speed',
            'Coordinates',
            # 'Status',
            # 'Position received',
    ):
        value = str(minsoup.find(string=attr).parent.next_sibling.string)
        if value in ('-',):
            dct[attr] = None
        else:
            dct[attr] = value

    try:
        dct['MMSI'] = dct['IMO / MMSI'].split(' / ')[-1].strip()
    except Exception:
        pass
    try:
        dct['Length'], dct['Beam'] = dct['Length / Beam'].split(' / ')
    except Exception:
        pass
    try:
        dct['Course'], dct['Speed'] = dct['Course / Speed'].split(' / ')
    except Exception:
        pass
    try:
        lat, long = dct['Coordinates'].split('/')
        num, direction = lat.split(' ')

        if direction == 'S':
            dct['latitude'] = '-' + num.strip()
        elif direction == 'N':
            dct['latitude'] = num.strip()
        else:
            print('FAILLLLLLL lat')

        num, direction = long.split(' ')
        if direction == 'W':
            dct['longitude'] = '-' + num.strip()
        elif direction == 'E':
            dct['longitude'] = num.strip()
        else:
            print('FAILLLLLLL long')
    except Exception:
        pass
    return dct


def scrape_vessel_(url: str, driver=None) -> dict:
    # url = 'https://www.vesselfinder.com/vessels/PRELUDE-IMO-9648714-MMSI-503000101'
    soup = get_soup_using_selenium(url, driver=driver)
    dct = get_vessel_particulars(soup)
    dct.update(**get_position_and_voyage_data(soup))
    print(dct)
    return dct


def scrape_vessels(input_file: str, output_file: str, start: int, stop: int, sleeptime: int = 3, driver=None):
    """ Scrape from links in input_file from [start, stop] """
    dicts = []
    with open(input_file, 'r') as f:
        links = f.read().splitlines()

    with open(output_file, 'w', newline='', encoding='utf-8') as csvfile:
        detail = scrape_vessel_(links[start - 1])
        print(f'scraping link {links[start - 1]}')
        dicts.append(detail)
        print(detail)
        writer = csv.DictWriter(csvfile, ['IMO number', 'Vessel Name', 'Ship type', 'Flag', 'Gross Tonnage',
                                          'Summer Deadweight (t)', 'Length Overall (m)', 'Beam (m)', 'Draught (m)',
                                          'Year of Built', 'TEU', 'Crude', 'Grain', 'Bale', 'AIS Type', 'Destination',
                                          'ETA', 'IMO / MMSI', 'Callsign', 'Length / Beam', 'Current draught',
                                          'Course / Speed', 'Coordinates', 'MMSI', 'Course', 'Speed', 'latitude',
                                          'longitude', 'Length', 'Beam'])
        writer.writeheader()

        for i, link in enumerate(islice(links, start, stop)):
            try:
                print(f'scraping link {link}')
                detail = scrape_vessel_(link, driver)
            except Exception:
                print('failed, trying again in 3 seconds')
                time.sleep(3)
                try:
                    print(f'scraping link {link}')
                    detail = scrape_vessel_(link)
                    print('All OK')
                except Exception:
                    print('still failed')
                    print(f'skipping, failed at around {start+i}')
            dicts.append(detail)
            print(detail)
            writer.writerow(detail)
            time.sleep(sleeptime)


if __name__ == '__main__':
    driver = webdriver.Chrome('C:\\App\\bin\\chromedriver.exe')
    scrape_vessels('../data/Ship_link.txt', 'test_vessels.txt', 10, 20, 1, driver=driver)
    driver.quit()
