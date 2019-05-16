import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt

x_data = np.array([
    [0,0],
    [0,1],
    [1,0],
    [1,1]
], dtype=np.float32)
y_data = np.array([
    [0],
    [0],
    [0],
    [1]
], dtype=np.float32)

X = tf.placeholder(tf.float32, [None, 2], name='x-input')
Y = tf.placeholder(tf.float32, [None, 1], name='y-input')

W = tf.Variable(tf.random_normal([2, 1]), name='weight')
b = tf.Variable(tf.random_normal([1]), name='bias')

hypothesis = tf.sigmoid(tf.matmul(X, W) + b)

W_history = []
cost_history = []
b_history = []

cost = -tf.reduce_mean(Y*tf.log(hypothesis) + (1-Y)*tf.log(1-hypothesis))
train = tf.train.GradientDescentOptimizer(learning_rate=0.01).minimize(cost)

predicted = tf.cast(hypothesis > 0.5, dtype=tf.float32)
accuracy = tf.reduce_mean(tf.cast(tf.equal(predicted, Y), dtype=tf.float32))

with tf.Session() as sess:
    sess.run(tf.global_variables_initializer())

    for step in range(10001):
        sess.run(train, feed_dict={X: x_data, Y: y_data})

        W_history.append(sess.run((W)))
        b_history.append(sess.run(b))
        cost_history.append(sess.run(cost, feed_dict={X: x_data, Y: y_data}))

    h, c, a = sess.run([hypothesis, predicted, accuracy], feed_dict={X: x_data, Y: y_data})
    print('\nHypothesis: ', h, '\nCorrect: ', c, '\nAccuracy: ', a)

plt.figure(figsize=[12, 6])
plt.subplot(1, 2, 1)
plt.plot(b_history)
plt.subplot(1, 2, 2)
plt.plot(cost_history)
plt.grid()
plt.show()