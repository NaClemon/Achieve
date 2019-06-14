from pymongo import MongoClient
import numpy as np
from scipy.stats import pearsonr

client = MongoClient('localhost', 27017)
database = client.project
collection = database.gameinforms
user_coll = database.user

pipelines = list()
pipelines.append({'$unwind': "$games"})
pipelines.append({'$unwind': "$games.genre"})
pipelines.append({'$project': {'_id': 1, 'test': "$games.genre"}})
pipelines.append({'$group': {'_id': "$_id", 'genres': {'$push': "$test"}}})
pipelines.append({'$match': {'_id': 'yong'}})

matrix = np.empty((0, 10))
forCount = ['Action', 'Adventure', 'Casual', 'Indie', 'Massively Multiplayer', 'Racing', 'RPG', 'Simulation',
            'Sports', 'Strategy']
results = user_coll.aggregate(pipelines)
for result in results:
    user = np.array([[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]])
    for i in range(len(result['genres'])):
        for j in range(len(forCount)):
            if (result['genres'][i] == forCount[j]):
                user[0][j] = user[0][j] + 1
    matrix = np.append(matrix, user, axis=0)

del pipelines[-1]
pipelines.append({'$match': {'_id': {'$ne':'yong'}}})
results = user_coll.aggregate(pipelines)

for result in results:
    user = np.array([[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]])
    for i in range(len(result['genres'])):
        for j in range(len(forCount)):
            if (result['genres'][i] == forCount[j]):
                user[0][j] = user[0][j] + 1
    matrix = np.append(matrix, user, axis=0)
    print(result)

for i in range(1, len(matrix)):
    corr = pearsonr(matrix[0], matrix[i])
    print(corr)
    if (i == 1):
        min1 = [i, corr]
        min2 = min1
    elif (i > 1):
        if (min1[1][1] > corr[1]):
            min2 = min1
            min1 = [i, corr]
        elif (min2[1][1] > corr[1]):
            min2 = [i, corr]

print(min1)
print(min2)

max = 0
for i in range(len(forCount)):
    avg = (matrix[min1[0]][i] + matrix[min2[0]][i]) / 2
    if (max < avg):
        max = i
print(max)
print(matrix)