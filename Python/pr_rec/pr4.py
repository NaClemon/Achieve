import tensorflow as tf
import numpy as np
import joblib
import librosa
import librosa.display
import os
import glob
import pickle
import sys
import matplotlib.pyplot as plt
from scipy.stats import pearsonr

np.set_printoptions(threshold=sys.maxsize)

genreDict = {
    0 : 'blues',
    1 : 'classical',
    2 : 'country',
    3 : 'disco',
    4 : 'hiphop',
    5 : 'jazz',
    6 : 'metal',
    7 : 'pop',
    8 : 'reggae',
    9 : 'rock',
}

def CNN_Layer(input, channel, filter, filterShape, poolShape):
    W = tf.Variable(tf.truncated_normal([filterShape[0], filterShape[1], channel, filter],stddev=0.03))
    Bias = tf.Variable(tf.truncated_normal([filter], stddev=0.01))

    Conv = tf.nn.conv2d(input, W, strides=[1, 1, 1, 1], padding='SAME') + Bias

    Layer = tf.nn.relu(Conv)
    poolingshape = [1, poolShape[0], poolShape[1], 1]
    Pool = tf.nn.max_pool(Layer, ksize=poolingshape, strides=poolingshape, padding='SAME')

    return Pool

def extract_features(basedir, extension='.mp3'):
    features = []
    names = []
    for root, dir, files in os.walk(basedir):
        files = glob.glob(os.path.join(root, '*' + extension))

        for f in files:
            file = f.split('/')[1].split('\\')[1].split('.')[0]
            print(file)
            y, sr = librosa.load(os.path.join(basedir, file + extension))

            mel_spec = librosa.feature.melspectrogram(y, sr=sr, n_mels=128, hop_length=1024, n_fft=2048)

            log_mel_spec = librosa.amplitude_to_db(mel_spec, ref=np.max)

            log_mel_spec = np.resize(log_mel_spec, (128, 644))
            features.append(log_mel_spec.flatten())

            names.append(file)

        features = np.asarray(features).reshape(len(features), 82432)

        return (features, names)

dataPath = 'C:/ffmpeg'
predictData, nameData = extract_features(dataPath)
print(predictData.shape)


X = tf.placeholder(tf.float32, [None, 82432])
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
hypothesis1 = tf.nn.dropout(hypothesis1, keepprob)

W2 = tf.Variable(tf.truncated_normal([256, 10], stddev=0.03))
B2 = tf.Variable(tf.truncated_normal([10], stddev=0.01))
logits = tf.matmul(hypothesis1, W2) + B2
y_ = tf.nn.softmax(logits)

saver = tf.train.Saver()

predictions = []


def getBatch(data, batchSize, iteration):
    startOfBatch = (iteration * batchSize) % len(data)
    endOfBatch = (iteration * batchSize + batchSize) % len(data)

    if startOfBatch < endOfBatch:
        return data[startOfBatch:endOfBatch]
    else:
        dataBatch = np.vstack((data[startOfBatch:],data[:endOfBatch]))

        return dataBatch

# targetMusic = np.array([[]])
# similarMusic = np.empty((0))

with tf.Session() as sess:
    sess.run(tf.global_variables_initializer())

    saver.restore(sess, 'train/model.ckpt')

    for i in range(len(nameData)):
        predictions = sess.run(y_, feed_dict={X: predictData[i:i+1], keepprob: 1.0})
        np.set_printoptions(suppress=True)
        print(predictions)

        # if (i == 0):
        #     targetMusic = predictions

        predictedGenre = np.argsort(predictions)[0][::-1]

        # pearsonCor, pValue = pearsonr(targetMusic[0], predictions[0])

        # if (i != 0 and pValue < 0.05):
        #     if (pearsonCor > 0.90):
        #         similarMusic = np.append(similarMusic, nameData[i])

        genreList = np.array([predictedGenre[0], predictedGenre[1]])
        genre = np.array([genreDict.get(genreList[0]), genreDict.get((genreList[1]))])
        print(nameData[i], ":", genre)
        # print("similarity: ", pearsonCor)
        # print("p-value: ", pValue)
        print('================')

    # data = getBatch(predictData, 7, 0)

    # print(predictions.where(max(predictions)))

# joblib.dump(predictions, 'result.prediction')

# print('List:', similarMusic)