# https://www.guru99.com/rnn-tutorial.html
# predict Time Series

import tensorflow as tf
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def create_ts(start='2001', n=201, freq='M'):
    rng = pd.date_range(start=start, periods=n, freq=freq)
    ts = pd.Series(np.random.uniform(-18, 18, size=len(rng)), rng).cumsum()
    return ts

ts = create_ts('2001', 201, 'M')

n_inputs = 4
n_neurons = 6
n_timesteps = 2

series = np.array(ts)
n_windows = 20
n_input = 1
n_output = 1
size_train = 201

train = series[:size_train]
test = series[size_train:]

x_data = train[:size_train-1]
x_batches = x_data.reshape(-1, n_windows, n_input)

def create_batches(df, windows, input, output):
    x_data = train[:size_train-1]
    x_batches = x_data.reshape(-1, windows, input)

    y_data = train[n_output:size_train]
    y_batches = y_data.reshape(-1, windows, output)

    return x_batches, y_batches

x_batches, y_batches = create_batches(train, n_windows, n_input, n_output)

x_test, y_test = create_batches(test, 20, 1, 1)

x = tf.placeholder(tf.float32, [None, n_windows, n_input])
y = tf.placeholder(tf.float32, [None, n_windows, n_output])

basic_cell = tf.contrib.rnn.BasicRNNCell(num_units=n_neurons, activation=tf.nn.relu)
rnn_output, states = tf.nn.dynamic_rnn(basic_cell, x, dtype=tf.float32)

stacked_rnn_output = tf.reshape(rnn_output, [-1, n_neurons])
stacked_output = tf.layers.dense(stacked_rnn_output, n_output)
outputs = tf.reshape(stacked_output, [-1, n_windows, n_output])

learning_rate = 0.001

loss = tf.reduce_sum(tf.square(outputs - y))
optimizer = tf.train.AdamOptimizer(learning_rate=learning_rate)
training_op = optimizer.minimize(loss)

correct = tf.equal(tf.arg_max(outputs, 1), tf.arg_max(y, 1))
accuracy = tf.reduce_mean(tf.cast(correct, tf.float32))

with tf.Session() as sess:
    init = tf.global_variables_initializer()
    init.run()
    for iters in range(1501):
        sess.run(training_op, feed_dict={x:x_batches, y:y_batches})
        if (iters % 150 == 0):
            mse = accuracy.eval(feed_dict={x:x_batches, y:y_batches})
            print(iters, '\taccuracy:', mse)
    y_pred = sess.run(outputs, feed_dict={x:x_test})

plt.title('forecast vs actual')
plt.plot(pd.Series(np.ravel(y_test)), "bo", markersize=4, label='actual', color='green')
plt.plot(pd.Series(np.ravel(y_pred)), "r.", markersize=8, label='forcast', color='red')
plt.legend(loc='lower left')
plt.xlabel('time')
plt.show()
