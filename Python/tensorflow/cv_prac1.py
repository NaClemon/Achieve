import cv2
import numpy as np
#------예제 6---------
src = cv2.imread('Image/a.jpg', cv2.IMREAD_COLOR)

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

cv2.imshow('src', src)
cv2.imshow('canny', canny)
cv2.imshow('sobel', sobel)
cv2.imshow('laplacian', laplacian)
# cv2.imshow('dst2', dst2)
cv2.waitKey(0)
cv2.destroyAllWindows()