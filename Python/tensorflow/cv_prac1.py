import cv2
import datetime
import numpy as np
#------예제 6---------
src = cv2.imread('Image/1.png', cv2.IMREAD_COLOR)

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
image = cv2.imread('Image/a.jpg', cv2.IMREAD_ANYCOLOR)
cv2.imshow('temp', image)
height, width, channel = image.shape
print(height, width, channel)
cv2.waitKey(0)
=======
=======
>>>>>>> d92131fff5559cc42296402fc783487e1ef77067
=======
>>>>>>> fc8b24ebc62e18a2b78e948229c25f12b51244db
#==윤곽선==
# gray = cv2.cvtColor(src, cv2.COLOR_BGR2GRAY)
# ret, binary = cv2.threshold(gray, 127, 255, cv2.THRESH_BINARY)
# binary = cv2.bitwise_not(binary)
# contours, hierachy = cv2.findContours(binary, cv2.RETR_CCOMP, cv2.CHAIN_APPROX_NONE)
# for i in range(len(contours)):
#     cv2.drawContours(src, [contours[i]], 0, (0, 0, 255), 2)
#     cv2.putText(src, str(i), tuple(contours[i][0][0]), cv2.FONT_HERSHEY_COMPLEX, 0.8, (0, 255, 0), 1)
#     print(i, hierachy[0][i])
#     cv2.imshow('src', src)
#     cv2.waitKey()

#==캡쳐 및 녹화
# capture = cv2.VideoCapture('Image/b.mp4')
# fourcc = cv2.VideoWriter_fourcc(*'XVID')
# record = False
# while True:
#     if(capture.get(cv2.CAP_PROP_POS_FRAMES) == capture.get(cv2.CAP_PROP_FRAME_COUNT)):
#         capture.open('Image/b.mp4')
#     ret, frame = capture.read()
#     cv2.imshow('video', frame)
#     now = datetime.datetime.now().strftime('%d_%H-%M-%S')
#     key = cv2.waitKey(33)
#     if (key == 27):
#         break
#     elif (key == 26):
#         print('캡처')
#         cv2.imwrite('Image/' + str(now) + '.png', frame)
#     elif (key == 24):
#         print('녹화시작')
#         record = True
#         video = cv2.VideoWriter('Image/' + str(now) + '.avi', fourcc, 20.0, (frame.shape[1], frame.shape[0]))
#     elif (key == 3):
#         print('녹화중지')
#         record = False
#     if (record == True):
#         print('녹화중...')
#         video.write(frame)

#==기하학적 변환==
# height, width, channel = src.shape
# srcPoint = np.array([[300, 200], [400, 200], [500, 500], [200, 500]], dtype=np.float32)
# dstPoint = np.array([[0, 0], [width, 0], [width, height], [0, height]], dtype=np.float32)
# matrix = cv2.getPerspectiveTransform(srcPoint, dstPoint)
# dst = cv2.warpPerspective(src, matrix, (width, height))

#==드로잉==
# src = np.zeros((768, 1366, 3), dtype=np.uint8)
# cv2.line(src, (100, 100), (1200, 100), (0, 0, 255), 3, cv2.LINE_AA)
# cv2.circle(src, (300, 300), 50, (0, 255, 0), cv2.FILLED, cv2.LINE_4)
# cv2.rectangle(src, (500, 200), (1000, 400), (255, 0, 0), 5, cv2.LINE_8)
# cv2.ellipse(src, (1200, 300), (100, 50), 0, 90, 180, (255, 255, 0), 2)
# pts1 = np.array([[100, 500], [300, 500], [200, 600]])
# pts2 = np.array([[600, 500], [800, 500], [700, 600]])
# cv2.polylines(src, [pts1], True, (0, 255, 255), 2)
# cv2.fillPoly(src, [pts2], (255, 0, 255), cv2.LINE_AA)
# cv2.putText(src, 'TEST', (900, 600), cv2.FONT_HERSHEY_COMPLEX, 2, (255, 255, 255), 3)

#==채널 분리, 병합==
# height, width, channel = src.shape
# zero = np.zeros((height, width, 1), dtype=np.uint8)
# b, g, r = cv2.split(src)
# # b = src[:,:,0]
# inversebgr = cv2.merge((zero, zero, r))

#==HSV, 채널 범위 병합==
# hsv = cv2.cvtColor(src, cv2.COLOR_BGR2HSV)
# h, s, v = cv2.split(hsv)
# lower_red = cv2.inRange(hsv, (0, 100, 100), (5, 255, 255))
# upper_red = cv2.inRange(hsv, (170, 100, 100), (180, 255, 255))
# added_red = cv2.addWeighted(lower_red, 1.0, upper_red, 1.0, 0.0)
# orange = cv2.bitwise_and(hsv, hsv, mask=added_red)
# orange = cv2.cvtColor(orange, cv2.COLOR_HSV2BGR)

#==가장자리 검출==
# gray = cv2.cvtColor(src, cv2.COLOR_BGR2GRAY)
# canny = cv2.Canny(gray, 100, 255)
# sobel = cv2.Sobel(gray, cv2.CV_8U, 1, 0, 3)
# laplacian = cv2.Laplacian(gray, cv2.CV_8U, ksize=3, borderType=cv2.BORDER_DEFAULT)

#==blur효과==
# dst = cv2.blur(src, (2, 15), anchor=(-1, -1), borderType=cv2.BORDER_DEFAULT)

#==이진화==
# gray = cv2.cvtColor(src, cv2.COLOR_BGR2GRAY)
# ret, dst = cv2.threshold(gray, 100, 255, cv2.THRESH_BINARY)

#==색상 반전==
# dst = cv2.bitwise_not(src)

#==색상 변경==
# dst = cv2.cvtColor(src, cv2.COLOR_BGR2GRAY)

#==이미지 자르기==
# dst = src.copy()
# roi = src[100:600, 200:700]
# dst[0:500, 0:500] = roi

#==크기 조정==
# dst = cv2.resize(src, dsize=(640, 480), interpolation=cv2.INTER_AREA)
# dst2 = cv2.resize(src, dsize=(0, 0), fx=0.3, fy=0.7, interpolation=cv2.INTER_LINEAR)

#==확대, 축소==
# height, width, channel = src.shape
# dst = cv2.pyrUp(src, dstsize=(width*2, height*2), borderType=cv2.BORDER_DEFAULT)
# dst2 = cv2.pyrDown(src)

#==회전==
# matrix = cv2.getRotationMatrix2D((width/2, height/2), 90, 1)
# matrix = np.array([[0, 1, height/2], [1, 0, width/2]])
# dst = cv2.warpAffine(src, matrix, (width, height))

# cv2.imshow('src', dst)
# # cv2.imshow('dst2', dst2)
# cv2.waitKey(0)
# capture.release()
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> d92131fff5559cc42296402fc783487e1ef77067
=======
>>>>>>> d92131fff5559cc42296402fc783487e1ef77067
=======
>>>>>>> fc8b24ebc62e18a2b78e948229c25f12b51244db
cv2.destroyAllWindows()