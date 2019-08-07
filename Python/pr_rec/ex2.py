import tensorflow as tf
from tensorflow.examples.tutorials.mnist import input_data
import os
import numpy as np
import PIL

np.set_printoptions(linewidth=1000)


def save_model(h5_path, model_path):
    model = tf.keras.Sequential()
    model.add(tf.keras.layers.Dense(10, activation='softmax', input_shape=[784]))

    model.compile(optimizer=tf.keras.optimizers.Adam(lr=0.001),
                  loss=tf.keras.losses.sparse_categorical_crossentropy,
                  metrics=['acc'])

    mnist = input_data.read_data_sets('mnist')
    model.fit(mnist.train.images, mnist.train.labels,
              validation_data=[mnist.validation.images, mnist.validation.labels],
              epochs=15, batch_size=128, verbose=0)

    # 케라스 모델과 변수 모두 저장
    model.save(h5_path)

    # -------------------------------------- #

    # 저장한 파일로부터 모델 변환 후 다시 저장
    converter = tf.lite.TFLiteConverter.from_keras_model_file(h5_path)
    flat_data = converter.convert()

    with open(model_path, 'wb') as f:
        f.write(flat_data)


save_model('ex2/mnist.h5', 'ex2/mnist.tflite')