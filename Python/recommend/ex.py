import numpy as np
import matplotlib
import matplotlib.pyplot as plt
matplotlib.style.use('ggplot')

alice = np.array([5, 3, 4, 4])
user1 = np.array([3, 1, 2, 3])
user2 = np.array([4, 3, 4, 3])
user3 = np.array([3, 3, 1, 5])
user4 = np.array([1, 5, 5, 2])

plt.scatter(alice, user1)
plt.show()

"""matrix = np.array([[0, 0, 5, 0, 4, 5],
                   [0, 0, 4, 0, 0, 5],
                   [3, 0, 5, 4, 5, 5],
                   [3, 2, 5, 0, 1, 5],
                   [2, 0, 5, 3, 5, 0],
                   [3, 5, 4, 4, 5, 1]
                   ])
corr = np.corrcoef(matrix)
print(corr)"""