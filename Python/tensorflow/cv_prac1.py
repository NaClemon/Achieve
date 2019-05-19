import cv2

image = cv2.imread('Image/a.jpg', cv2.IMREAD_UNCHANGED)

cv2.imshow('Moon', image)
cv2.waitKey(0)
cv2.destroyAllWindows()