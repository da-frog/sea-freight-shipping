import requests
import urllib.request
from bs4 import BeautifulSoup


def get_link(soup: BeautifulSoup):
    text_file = open("../data/port-link-country.text", "a")
    for link in soup.find(id='clist').find_all("a", href=True):
        marine_link = "https://www.searates.com/" + f"{link['href']}" + '\n'
        text_file.write(marine_link)

    text_file.close()


url = "https://www.searates.com/maritime/"
html = urllib.request.urlopen(url)
soup = BeautifulSoup(html, 'html.parser')

get_link(soup)