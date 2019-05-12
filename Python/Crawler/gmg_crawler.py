from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.action_chains import ActionChains
from bs4 import BeautifulSoup
import requests
import time
import re
import os
import json

driver = webdriver.Chrome('D:\Workspace\Python\Crawler\chromedriver.exe')
base_dir = os.path.dirname(os.path.abspath(__file__))

datas = []

path = 'https://www.greenmangaming.com/bestsellers/'
game_page_url = 'https://www.greenmangaming.com'
driver.get(path)

# for page in range(1, 2):
#     data = {}

for i in range(0, 6):
    gmae_page = driver.page_source
    game_inform = BeautifulSoup(gmae_page, 'lxml')
    y = 750*(i+1)
    driver.execute_script("window.scrollTo(0, " + str(y) + ");")
    time.sleep(2)
    # if (i != 0):
    driver.find_element_by_xpath('//*[@class="load-more"]').click()
    driver.implicitly_wait(3)
    time.sleep(2)
    driver.implicitly_wait(3)
    games = game_inform.find('ul', attrs={'class', 'table-search-listings'})
    #game = requests.get(games).text
    for i in range(11, 12):
        driver.implicitly_wait(3)
        time.sleep(2)
        p = '//*[@class="table-search-listings"]/li[' + str(10+i) + ']/div/div/div/a'
        driver.find_element_by_xpath(p).click()
        driver.back()
    for j in range(10, 20):
        game = games[j].select('div > div.item-description > div > a > p')
        print(game[0].text)

        try:
            informs = games[j].find('div', attrs={'class', 'col-xs-2 text-right hidden-xs prices prices-no-discount'})
            inform = informs.select('div > p > span > price > span')
            normal_price = re.sub('\t|\n|원|,|₩| ', '', inform[0].text)
            sale_price = '-1'
            print(normal_price, sale_price)
        except:
            informs = games[j].find('div', attrs={'class', 'col-xs-1 text-right hidden-xs prices prices-discount'})
            inform = informs.select('div > p > span > price > span')
            normal_price = re.sub('\t|\n|원|,|₩| ', '', inform[0].text)
            sale_price = re.sub('\t|\n|원|,|₩| ', '', inform[1].text)
            print(normal_price, sale_price)
        # try:
        #     inform = games[j].select('div.col-xs-2 text-right hidden-xs prices prices-no-discount')
        #     print(inform)
        # except:
        #     inform = games[j].select('div.col-xs-1 text-right hidden-xs prices prices-discount > div > p')
        #     print(inform)