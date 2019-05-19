from pymongo import MongoClient
from bs4 import BeautifulSoup
import requests
import matplotlib.pyplot as plt
from matplotlib import font_manager, rc
import re

page = requests.get("https://finance.naver.com/sise/lastsearch2.nhn")
soup = BeautifulSoup(page.content, 'lxml')
link = soup.find(class_='type_5')

list = link.find_all('tr')

client = MongoClient('localhost', 27017)
database = client.weatherdb
collection = database.dust

title = '주식 등락률'
xlab = '종목명'
ylab = '등락률'

font_name = font_manager.FontProperties(fname='c:/Windows/Fonts/malgun.ttf').get_name()
rc('font', family=font_name)

plt.title(title)
plt.xlabel(xlab)
plt.ylabel(ylab)

name = []
price = []
last_price = []

# for informs in list:
#     inform = informs.find_all('td')
#     try:
#         name = inform[1].get_text()
#         price_t = inform[3].get_text()
#         per = inform[5].get_text()
#         price = re.sub(',', '', price_t)
#         perc = re.sub('\t|\n| |\%', '', per)
#         a = float(perc)
#         last_price = float(price) * ((100 + (-1 * a))/100)
#
#         title_id = collection.insert_one({'name': name, 'price': price, 'last_price': last_price})
#     except IndexError as e:
#         pass
