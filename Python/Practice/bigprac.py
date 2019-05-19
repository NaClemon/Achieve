from bs4 import BeautifulSoup
import requests

page = requests.get("https://web.kma.go.kr/home/index.tab.now-ten.jsp?gubun=1&myPointCode=&unit=M")
soup = BeautifulSoup(page.content, 'html.parser')
link = soup.find(class_='weather')
# a = link.find_all('dl')
# for i in a:
#     name = i.find('dt')
#     temp = i.find(class_='temp')
#     print(name.get_text() + ': ' + temp.get_text())

list_of_dl = link.find_all("dl")

for in_each_dl in list_of_dl:
    list_of_dt = in_each_dl.find_all("dt")[0]
    temp = in_each_dl.find_all('dd')[1]
    img = in_each_dl.find('img').attrs['alt']
    print("City name: " + list_of_dt.get_text(), 'Temparature: ' + temp.get_text()
          , 'Weather: ' + img)
