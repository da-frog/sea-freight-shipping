import csv


from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait


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
        if value in ('-', ):
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
        if value in ('-', ):
            dct[attr] = None
        else:
            dct[attr] = value

    dct['MMSI'] = dct['IMO / MMSI'].split(' / ')[-1].strip()
    dct['Length'], dct['Beam'] = dct['Length / Beam'].split(' / ')
    dct['Course'], dct['Speed'] = dct['Course / Speed'].split(' / ')
    lat, long = dct['Coordinates'].split('/')
    num, direction = lat.split(' ')
    if direction == 'S':
        dct['latitude'] = '-' + num.strip()
    elif direction == 'N':
        dct['latitude'] = num.strip()
    else:
        print('FAILLLLLLL')
    num, direction = long.split(' ')
    if direction == 'W':
        dct['longitude'] = '-' + num.strip()
    elif direction == 'E':
        dct['longitude'] = num.strip()
    else:
        print('FAILLLLLLL')
    return dct


if __name__ == '__main__':
    url = 'https://www.vesselfinder.com/vessels/PRELUDE-IMO-9648714-MMSI-503000101'
    soup = get_soup_using_selenium(url)
    dct = get_vessel_particulars(soup)
    dct.update(**get_position_and_voyage_data(soup))
    print(dct)
    with open('test.csv', 'w') as f:
        writer = csv.DictWriter(f, dct.keys())
        writer.writeheader()
        writer.writerow(dct)

