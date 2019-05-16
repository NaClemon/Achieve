import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

raw_data = np.genfromtxt('x09.txt', skip_header=36)

x_data = np.array(raw_data[:, 2:4], dtype=np.float32)
y_data = np.array(raw_data[:, 4], dtype=np.float32)

y_data = y_data.reshape((25, 1))

X = tf.placeholder(tf.float32, shape=[None, 2], name='x-input')
Y = tf.placeholder(tf.float32, shape=[None, 1], name='x-input')

W = tf.Variable(tf.random_normal([2, 1]), name='weight')
b = tf.Variable(tf.random_normal([1]), name='bias')

hypothesis = tf.matmul(X, W) + b

cost = tf.reduce_mean(tf.square(hypothesis - Y))

optimizer = tf.train.GradientDescentOptimizer(learning_rate=0.0001)
train = optimizer.minimize(cost)

with tf.Session() as sess:
    sess.run(tf.global_variables_initializer())
    cost_history = []

    for step in range(2001):
        cost_val, hy_val, _train = sess.run([cost, hypothesis, train], feed_dict={X: x_data, Y: y_data})
        if (step%10 == 0):
            print(step, "Cost: ", cost_val)
            cost_history.append(sess.run(cost, feed_dict={X: x_data, Y: y_data}))

    print(sess.run(hypothesis, feed_dict={X: [[55, 25]]}))

plt.figure(figsize=[12, 6])
plt.plot(cost_history)
plt.grid()
plt.show()
