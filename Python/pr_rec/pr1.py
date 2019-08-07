import pandas as pd
from pandas import DataFrame
import re
import time
from sklearn.metrics import jaccard_similarity_score
from ast import literal_eval

start = time.time()

def get_list(x):
    p = re.compile('[A-Z][a-z]+')
    names = p.findall(x)
    return names

def change_title(x):
    names = re.sub(' \([0-9]+\)$', '', x)
    return names


users = pd.read_csv('C:/dump/ml-latest-small/ratings.csv', delimiter=',')
movies = pd.read_csv('C:/dump/ml-latest-small/movies.csv', delimiter=',')

movies['genres'] = movies['genres'].apply(get_list)
movies['title'] = movies['title'].apply(change_title)

users = users[['userId', 'movieId']]
users = users.values
movies = DataFrame(movies, columns=['movieId', 'title', 'genres', 'users'])

movies = movies.set_index('movieId').to_dict()

for user in users:
    if (isinstance(movies['users'][user[1]], list)):
        movies['users'][user[1]].append(user[0])
    else:
        movies['users'][user[1]] = [user[0]]

def jaccard_sim(x, y):
    x = set(x)
    y = set(y)
    intersection = x & y
    union = x | y
    return len(intersection) / len(union)

def overlap_sim(x, y):
    x = set(x)
    y = set(y)

    intersection = x & y
    if (len(x) < len(y)):
        return len(intersection) / len(x)
    else:
        return len(intersection) / len(y)

temp_user = [1, 26, 623, 2, 516, 7, 346, 263, 1241, 6231, 224]
indexes = []

for i in range(1, len(movies['title']) + 1):
    for j in range(1 + 1, len(movies['title']) + 1):
        if (i == j or i not in movies['users'] or j not in movies['users']):
            continue
        if not (isinstance(movies['users'][i], list) and isinstance(movies['users'][j], list)):
            continue
        m = overlap_sim(movies['users'][i], movies['users'][j])
        if (m > 0.95):
            indexes.append([i, j])

def recommended(user):
    movie_list = []
    for u in user:
        for i in indexes:
            if (i[0] == u and i[1] not in user):
                movie_list.append(i[1])

    return movie_list

for movie in recommended(temp_user):
    print(movies['title'][movie])

print(time.time() - start)


