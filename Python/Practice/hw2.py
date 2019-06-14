from pymongo import MongoClient
from bs4 import BeautifulSoup
import requests
import re
import matplotlib.pyplot as plt
from matplotlib import font_manager, rc

font_name = font_manager.FontProperties(fname='c:/Windows/Fonts/malgun.ttf').get_name()
rc('font', family=font_name)

header = {'User-Agent':'Chrome/66.0.3359.181'}
url = "https://www.worlddata.info/average-income.php"

client = MongoClient('localhost', 27017)
database = client.test
collection = database.income

page = requests.get(url, headers=header)
soup = BeautifulSoup(page.content, 'html.parser')

list = soup.find('table', attrs={'class': 'std100 hover'})
countries = list.findAll('tr')

for i in range(1, 78):
    try:
        inform = countries[i].findAll('td')
        name = inform[1].text
        income_annual = int(re.sub(',|[$]| ', '', inform[2].text))
        income_month = int(re.sub(',|[$]| ', '', inform[3].text))
        dataindb = collection.insert_one({'name': name, 'annual': income_annual, 'month': income_month})
    except:
        break

an_docs = collection.find({}, {'_id': 0}).sort('annual', -1)

an_inform_name = []
an_inform_inan = []
etc_incomeAnn = 0
i = 0

for doc in an_docs:
    country, incomeAnn, incomeMon = doc.values()
    if (i < 9):
        an_inform_name.append(country)
        an_inform_inan.append(incomeAnn)
    else:
        etc_incomeAnn += incomeAnn
    i += 1

an_inform_name.append('Others')
an_inform_inan.append(etc_incomeAnn)

for j in range(len(an_inform_name)):
    print(an_inform_name[j], an_inform_inan[j])

plt.pie(an_inform_inan, labels=an_inform_name, startangle=90, autopct='%1.1f%%')
plt.show()