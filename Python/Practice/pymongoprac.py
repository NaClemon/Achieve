from pymongo import MongoClient
from bs4 import BeautifulSoup
import requests
import matplotlib.pyplot as plt
from matplotlib import font_manager, rc

page = requests.get("https://web.kma.go.kr/home/index.tab.now-ten.jsp?gubun=1&myPointCode=&unit=M")
soup = BeautifulSoup(page.content, 'html.parser')
link = soup.find(class_='weather')

list_of_dl = link.find_all("dl")

client = MongoClient('localhost', 27017)
database = client.weatherdb
collection = database.weathercol

# for in_each_dl in list_of_dl:
#     list_of_dt = in_each_dl.find_all("dt")[0]
#     temp = in_each_dl.find_all('dd')[1]
#     img = in_each_dl.find('img').attrs['alt']
#     title_id = collection.insert_one({'city': list_of_dt.get_text(), 'temp': temp.get_text(),
#                                   'weather': img})

docs = collection.find({}, {'_id':0}).sort('city', 1)
font_name = font_manager.FontProperties(fname='c:/Windows/Fonts/malgun.ttf').get_name()
rc('font', family=font_name)

city = []
temp = []

for doc in docs:
    inform = list(doc.values())
    city.append(inform[0])
    temp.append(inform[1])

title = '도시별 기온 분포'
xlab = '도시'
ylab = '온도'
plt.xlabel(xlab)
plt.ylabel(ylab)
plt.title(title)

plt.plot(city, temp)
plt.show()