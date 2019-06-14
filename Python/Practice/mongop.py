from pymongo import MongoClient
import matplotlib.pyplot as plt
import numpy as np
from sklearn.cluster import KMeans, SpectralClustering

client = MongoClient('localhost', 27017)
database = client.test
collection = database.sample

docs = collection.find({}, {'_id':0})
X = np.empty((0,2), float)

for doc in docs:
    x, y = doc.values()
    X = np.concatenate((X, [[x, y]]), axis=0)

print(X)

kmeans = KMeans(n_clusters=31)
kmeans.fit(X)

model = SpectralClustering(n_clusters=31, affinity='nearest_neighbors', assign_labels='kmeans')
labels = model.fit_predict(X)

plt.subplot(1, 2, 1)
plt.scatter(X[:,0],X[:,1], c=kmeans.labels_, cmap='rainbow')
plt.scatter(kmeans.cluster_centers_[:,0] ,kmeans.cluster_centers_[:,1], color='black')

plt.subplot(1, 2, 2)
plt.scatter(X[:,0],X[:,1], c=labels, cmap='rainbow')

plt.show()