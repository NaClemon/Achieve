# https://www.guru99.com/rnn-tutorial.html
# predict Time Series

import tensorflow as tf
import numpy as np
import pandas as pd

def create_ts(start='2001', n=201, freq='M'):
    rng = pd.date_range(start=start, periods=n, freq=freq)
    ts = pd.Series(np.random.uniform(-18, 18, size=len(rng)), rng).cumsum()
    return ts

ts = create_ts('2001', 192, 'M')

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