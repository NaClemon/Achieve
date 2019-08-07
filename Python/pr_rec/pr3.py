import tensorflow as tf
import numpy as np
import joblib
import pickle
import sys

np.set_printoptions(threshold=sys.maxsize)

def CNN_Layer(input, channel, filter, filterShape, poolShape):
    W = tf.Variable(tf.truncated_normal([filterShape[0], filterShape[1], channel, filter],stddev=0.03))
    Bias = tf.Variable(tf.truncated_normal([filter], stddev=0.01))

    Conv = tf.nn.conv2d(input, W, strides=[1, 1, 1, 1], padding='SAME') + Bias

    Layer = tf.nn.relu(Conv)
    poolingshape = [1, poolShape[0], poolShape[1], 1]
    Pool = tf.nn.max_pool(Layer, ksize=poolingshape, strides=poolingshape, padding='SAME')

    return Pool

trainData = []
trainLabel = []

trainData = joblib.load('4GenreTest.data')
trainLabel = joblib.load('4GenreTest.labels')

testData = []
testLabels = []
with open('4GenreTest.data', 'rb') as f:
  testData = pickle.load(f)
with open('4GenreTest.labels', 'rb') as f:
  testLabels = pickle.load(f)

permutation = np.random.permutation(testData.shape[0])
testData = testData[permutation]
testLabels = testLabels[permutation]

permutation = np.random.permutation(trainData.shape[0])
trainData = trainData[permutation]
trainLabel = trainLabel[permutation]

X = tf.placeholder(tf.float32, [None, 82432])
Y = tf.placeholder(tf.float32, [None, 10])
keepprob = tf.placeholder(tf.float32)

reX = tf.reshape(X, [-1, 644, 128, 1])

layer1 = CNN_Layer(reX, 1, 32, [8, 8], [2, 2])
layer2 = CNN_Layer(layer1, 32, 64, [8, 8], [2, 2])
layer3 = CNN_Layer(layer2, 64, 128, [8, 8], [2, 2])

print(layer1.shape)
print(layer2.shape)
print(layer3.shape)

layer3re = tf.reshape(layer3, [-1, 128*16*81])
W1 = tf.Variable(tf.truncated_normal(shape=[128*16*81, 256], stddev=0.03))
B1 = tf.Variable(tf.truncated_normal(shape=[256], stddev=0.01))
hypothesis1 = tf.matmul(layer3re, W1) + B1
hypothesis1 = tf.nn.relu(hypothesis1)
# hypothesis1 = tf.nn.dropout(hypothesis1, keepprob)

W2 = tf.Variable(tf.truncated_normal([256, 10], stddev=0.03))
B2 = tf.Variable(tf.truncated_normal([10], stddev=0.01))
logits = tf.matmul(hypothesis1, W2) + B2
y_ = tf.nn.softmax(logits)

print(hypothesis1.shape)

Loss = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(logits=logits, labels=Y))
Optimizer = tf.train.AdamOptimizer(learning_rate=0.001).minimize(Loss)

correct_prediction = tf.equal(tf.argmax(Y, 1), tf.argmax(y_, 1))
accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))

def getBatch(data, labels, batchSize, iteration):
    startOfBatch = (iteration * batchSize) % len(data)
    endOfBatch = (iteration * batchSize + batchSize) % len(data)

    if startOfBatch < endOfBatch:
        return data[startOfBatch:endOfBatch], labels[startOfBatch:endOfBatch]
    else:
        dataBatch = np.vstack((data[startOfBatch:],data[:endOfBatch]))
        labelsBatch = np.vstack((labels[startOfBatch:],labels[:endOfBatch]))

        return dataBatch, labelsBatch

saver = tf.train.Saver()

with tf.Session() as sess:
    sess.run(tf.global_variables_initializer())
    print('check')
    for i in range(10): # 10
        print('epoch: ', i+1)
        for i in range(236): # 236
            #average cross_entropy for each epoch
            avg_cost = 0
            # for i in range(batch_size):
            batch_x, batch_y = getBatch(trainData, trainLabel, 10, i)
            # train network with batch data
            # batch_x = np.reshape(batch_x, [-1, 164864])
            # batch_y = np.reshape(batch_y, [-1, 3])
            _, cost, batch_acc = sess.run([Optimizer, Loss, accuracy],feed_dict={X: batch_x, Y: batch_y, keepprob: 0.75})
            #output accuracy and loss for batch
            print("Mini-Epoch:", (i + 1) , "accuracy: {:.3f}".format(batch_acc), "loss: {:.3f}".format(cost))

    saver.save(sess, 'train/model.ckpt')
    tf.train.write_graph(sess.graph_def, ".", 'train/model.pb', as_text=False)
    tf.train.write_graph(sess.graph_def, ".", 'train/model.txt', as_text=True)

    converter = tf.lite.TFLiteConverter.from_session(sess, [X], [y_])
    data = converter.convert()
    with open('train/model.tflite', 'wb') as f:
        f.write(data)