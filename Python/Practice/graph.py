import matplotlib.pyplot as plt
import matplotlib.animation as anim
from collections import deque
import random

MaxX = 100
MaxY = 1000

line = deque([0.0]*MaxX, maxlen=MaxX)

def update(fn, data):
    dy = random.randint(-5, 5)

    line.append(line[MaxX - 1] + dy)

    data.set_data(range(int(-MaxX/2), int(MaxX/2)), line)




fig = plt.figure()
a = plt.axes(xlim=(-(MaxX/2),MaxX/2), ylim=(-(MaxY/2),MaxY/2))
l1, = a.plot([], [])
ani = anim.FuncAnimation(fig=fig, func=update, fargs=(l1, ), interval=50)
plt.show()