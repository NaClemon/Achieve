import matplotlib.pyplot as plt
import numpy as np
from sklearn.cluster import KMeans, SpectralClustering
from sklearn.datasets import make_moons, make_circles

# X = np.array([
#     [-1, 0],
#     [-0.8, 0.25],
#     [-0.7, 0.63],
#     [-0.3, 0.8],
#     [0.0, 1.0],
#     [0.5, 0.75],
#     [0.8, 0.35],
#     [0.0, 0.5],
#     [0.3, -0.15],
#     [0.5, -0.35],
#     [1.0, -0.5],
#     [1.5, -0.4],
#     [1.8, -0.1],
#     [2.0, 0.25]
# ], np.float32)

X, y = make_moons(n_samples=1000, noise=0.05)
# X, y = make_circles(n_samples=1000, noise=0.05, factor=0.5)

kmeans = KMeans(n_clusters=2)
kmeans.fit(X)

model = SpectralClustering(n_clusters=2, affinity='nearest_neighbors', assign_labels='kmeans')
labels = model.fit_predict(X)

plt.subplot(1, 2, 1)
plt.scatter(X[:,0],X[:,1], c=kmeans.labels_, cmap='rainbow')
plt.scatter(kmeans.cluster_centers_[:,0] ,kmeans.cluster_centers_[:,1], color='black')

plt.subplot(1, 2, 2)
plt.scatter(X[:, 0], X[:, 1], c=labels, s=50, cmap='viridis')
plt.scatter(kmeans.cluster_centers_[:,0] ,kmeans.cluster_centers_[:,1], color='red')
plt.show()