import tensorflow as tf
import numpy as np


def make_model(model_path, sess, inputs, outputs):
    # inputs와 outputs가 여러 요소를 갖는다면 다중 입출력이 된다.
    converter = tf.lite.TFLiteConverter.from_session(sess, inputs, outputs)
    flat_data = converter.convert()

    with open(model_path, 'wb') as f:
        f.write(flat_data)


# and 논리값.
# [0, 0] => [0]
# [1, 1] => [1]
x = [[0, 0], [0, 1], [1, 0], [1, 1]]    # np로 변환하지 않아도 됨
y = np.float32([[0], [0], [0], [1]])    # 변환하지 않으면 z와 타입 불일치 에러

# 2와 1을 변수로 대체하면 지저분해지기 때문에 생략
# n_features, n_classes = len(x[0]), len(y[0])      # 2, 1

holder_x = tf.placeholder(tf.float32, shape=[None, 2])

w = tf.Variable(np.random.rand(2, 1), dtype=tf.float32)
b = tf.Variable(np.random.rand(1), dtype=tf.float32)

# (4, 1) = (4, 2) @ (2, 1)
z = tf.matmul(holder_x, w) + b          # fully connected 레이어
hx = tf.nn.sigmoid(z)                   # 활성 함수

# 정수 형변환. 텐서플로 연산이기 떄문에 모델에 포함되고, 안드로이드에서 사용할 수 있다.
# hx는 실수 배열, logics는 정수 배열. 일부러 출력 결과를 다르게 만들었다.
logics = tf.cast(hx >= 0.5, dtype=tf.int32)

loss = tf.nn.sigmoid_cross_entropy_with_logits(labels=y, logits=z)
train = tf.train.GradientDescentOptimizer(0.1).minimize(loss)

with tf.Session() as sess:
    sess.run(tf.global_variables_initializer())

    for i in range(100):
        sess.run(train, {holder_x: x})

    # print(sess.run([hx, logics], {holder_x: x}))
    #     hx : [[0.04933239], [0.22989444], [0.24103162], [0.64626104]],
    # logics : [[0], [0], [0], [1]]

    # 출력 1개인 모델과 2개인 모델을 별도 생성
    make_model('ex/and_model_for_hx_only.tflite', sess, [holder_x], [hx])
    make_model('ex/and_model_for_hx_logics.tflite', sess, [holder_x], [hx, logics])