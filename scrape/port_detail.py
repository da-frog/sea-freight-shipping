import requests
from bs4 import BeautifulSoup

res = requests.get('https://www.searates.com/port/durres_al.htm')
soup = BeautifulSoup(res.text, 'html.parser')


def find_address(soup: BeautifulSoup):
    a = soup.find(**{'class': 'table table-bordered'}).find(string='Address:').parent
    address = str(a.next_sibling.next_sibling)[4:-5].split('<br/>')
    return address


def find_fax(soup: BeautifulSoup):
    f = soup.find(**{'class': 'table table-bordered'}).find(string='Fax:').parent
    fax = str(f.next_sibling.next_sibling)[4:-5]
    return fax

address = find_address(soup)
fax = find_fax(soup)

print(address)
print(fax)
