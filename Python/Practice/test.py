from pymongo import MongoClient
import matplotlib.pyplot as plt
import numpy as np
import math
import re

#title, img, description, price, genre, developer, publisher, date
client = MongoClient('localhost', 27017)
database = client.project
collection = database.games
othersites = database.othersite

pipelines = list()
pipelines.append({'$unwind': "$tests"})
pipelines.append({'$unwind': "$tests.test"})
pipelines.append({'$project': {'_id':1, 'test':"$tests.test"}})
pipelines.append({'$group': {'_id':"$_id", 'tests':{'$push': "$test"}}})
pipelines.append({'$match': {'_id':{'$ne':'a'}}})
# pipelines = list()
# pipelines.append({'$unwind': "$games"})
# pipelines.append({'$unwind': "$games.genre"})
# pipelines.append({'$project': {'_id':1, 'test':"$games.genre"}})
# pipelines.append({'$group': {'_id':"$_id", 'genres':{'$push': "$test"}}})
# pipelines.append({'$match': {'_id':'a'}})


other_page = []
other_prices = []
informs = collection.find({'title': {'$regex': 'battleground', '$options':'i'}}).limit(1)
for inform in informs:
    print(inform)
    other_page.append(inform['prices'][0]['store_name'])
    other_prices.append(inform['prices'][0]['sale_price'])
siteinform = othersites.find({'_id': {'$regex': 'battleground', '$options': 'i'}}).limit(1)
for sitein in siteinform:
    for temp in sitein['prices']:
        if (temp['normal_price'] == -1):
            continue
        elif (temp['sale_price'] == -1):
            other_prices.append(temp['normal_price'])
        else:
            other_prices.append(temp['sale_price'])
        other_page.append(temp['store_name'])

plt.bar(other_page, other_prices, align='center', width=0.3)
plt.show()

# matrix = np.empty((0, 10))
# # forCount = [1, 2, 3, 4]
# forCount = ['Action','Adventure','Casual','Indie','Massively Multiplayer','Racing','RPG','Simulation','Sports','Strategy']
# results = collection.aggregate(pipelines)
# for result in results:
#     print(result)
#
# a = []
# a = [1, 2]
# a.append(3)
# b = a
# print(b)
#
# for result in results:
#     user = np.array([[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]])
#     for i in range(len(result['genres'])):
#         for j in range(len(forCount)):
#             if (result['genres'][i] == forCount[j]):
#                 user[0][j] = user[0][j] + 1
#     matrix = np.append(matrix, user, axis=0)
#
# user = np.array([[1,4,2,3,5,7,4,2,1,0]])
# matrix = np.append(matrix, user, axis=0)
# user = np.array([[6,2,5,7,3,2,6,8,1,1]])
# matrix = np.append(matrix, user, axis=0)
#
# print(matrix)
#
# for i in range(len(matrix)):
#     sum = 0
#     for j in range(len(matrix[i])):
#         if (matrix[0][j] == 0):
#             continue
#         print(forCount[j], matrix[0][j])
#         temp = matrix[0][j] - matrix[i][j]
#         sum = sum + temp**2
#     result = math.sqrt(float(sum))
#     print(result, "matirx", i, "번째")



# matrix.append([1, 2])
# print(matrix)

# informs = collection.find({'title':"c", "test.a": 3}).count(True)
#
# print(informs)
# word = "['Action', 'RPG']"
# word = re.sub("\'|\[|\]| ", '', word)
# print(word)
# temp = word.split(',')
# for i in temp:
#     print(i)
# from apyori import apriori

