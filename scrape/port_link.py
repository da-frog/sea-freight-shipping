import csv

import requests
import urllib.request
from bs4 import BeautifulSoup


def get_country_link(soup: BeautifulSoup):
    text_file = open("../scraped_data/port-link-country.text", "a")
    for link in soup.find(id='clist').find_all("a", href=True):
        marine_link = "https://www.searates.com/" + str(link['href'])
        text_file.write(marine_link + '\n')
    text_file.close()


def get_country_links_and_names(soup: BeautifulSoup) -> list:
    lst = []
    for a in soup.find(id='clist').find_all("a", href=True):
        country_link = "https://www.searates.com/" + a['href']
        lst.append((country_link, list(a.strings)[0].strip()))
    return lst


def scrape_country_links_and_names(output_file: str):
    res = requests.get("https://www.searates.com/maritime/")
    soup = BeautifulSoup(res.text, 'html.parser')
    lst = get_country_links_and_names(soup)
    with open(output_file, 'w') as csvfile:
        csvfile.write('Country Link,Country Name\n')
        for row in lst:
            csvfile.write(','.join(map(str, row)) + '\n')


def get_port_links_and_names(soup: BeautifulSoup) -> list:
    lst = []
    for each_port in soup.find(id='plist').find_all("a", href=True):
        port_link = "https://www.searates.com" + each_port["href"]
        lst.append((port_link, each_port.string))
    return lst


def scrape_port_links_and_names(input_file: str, output_file: str):
    urls = []
    countries = []
    with open(input_file, 'r') as f:
        reader = csv.DictReader(f)
        for row in reader:
            urls.append(row['Country Link'])
            countries.append(row['Country Name'])

    with open(output_file, 'w') as csvfile:
        csvfile.write('Port Link,Port Name,Country Name\n')

        for url, country in zip(urls, countries):
            res = requests.get(url)
            soup = BeautifulSoup(res.text, 'html.parser')
            lst = get_port_links_and_names(soup)
            for row in lst:
                csvfile.write(','.join(map(str, row)) + f',{country}\n')


def get_each_port_link(file_name: str):
    url_link = open(file_name, "r").read()
    url_list_link = url_link.split()
    port_file = open("../scraped_data/port-link.text", "a")

    for link in url_list_link:
        html = urllib.request.urlopen(link)
        soup = BeautifulSoup(html, 'html.parser')
        for each_port in soup.find(id='plist').find_all("a", href=True):
            port_link = "https://www.searates.com" + each_port["href"]
            port_file.write(port_link + "\n")
    port_file.close()


# Get Country

# url = "https://www.searates.com/maritime/"
# html = urllib.request.urlopen(url)
# soup = BeautifulSoup(html, 'html.parser')

# Get Port
# port_country = "../data/port-link-country.text"
# get_each_port_link(port_country)
