import requests
import urllib.request
from bs4 import BeautifulSoup


def get_country_link(soup: BeautifulSoup):
    text_file = open("../data/port-link-country.text", "a")
    for link in soup.find(id='clist').find_all("a", href=True):
        marine_link = "https://www.searates.com/" + f"{link['href']}" + '\n'
        text_file.write(marine_link)

    text_file.close()


def get_each_port_link(file_name: str):
    url_link = open(file_name, "r").read()
    url_list_link = url_link.split()
    port_file = open("../data/port-link.text", "a")

    for link in url_list_link:
        html = urllib.request.urlopen(link)
        soup = BeautifulSoup(html, 'html.parser')
        for each_port in soup.find(id = 'plist').find_all("a", href=True):
            port_link = "https://www.searates.com" + each_port["href"] + "\n"
            port_file.write(port_link)
    port_file.close()


# Get Country

# url = "https://www.searates.com/maritime/"
# html = urllib.request.urlopen(url)
# soup = BeautifulSoup(html, 'html.parser')

# Get Port
port_country = "../data/port-link-country.text"
get_each_port_link(port_country)
