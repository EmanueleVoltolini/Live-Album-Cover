
####################Image Semantic Segmentation########################

import os
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import cv2
from keras_segmentation.pretrained  import pspnet_50_ADE_20K , pspnet_101_cityscapes, pspnet_101_voc12

model = pspnet_50_ADE_20K() # load the pretrained model trained on ADE20k dataset

model1 = pspnet_101_cityscapes() # load the pretrained model trained on Cityscapes dataset

model2 = pspnet_101_voc12() # load the pretrained model trained on Pascal VOC 2012 dataset

# load any of the 3 pretrained models
# The first pre-trained model is the best for our task

out = model.predict_segmentation(
    inp="image_semantic_segmentation/image/Ripe.jpg",
    out_fname="image_semantic_segmentation/image/out.png"
)
img = mpimg.imread('image_semantic_segmentation/image/Ripe.jpg')

#plt.figure(figsize=(15,6))
#plt.subplot(1,2,1)
#imgplot = plt.imshow(img)
#plt.subplot(1,2,2)
#imgplot = plt.imshow(out)

out2 = model.predict_segmentation(
    inp="image_semantic_segmentation/image/Dark_side_of_the_moon.jpg",
    out_fname="image_semantic_segmentation/image/out.png"
)
img2 = mpimg.imread('image_semantic_segmentation/image/Dark_side_of_the_moon.jpg')

#plt.figure(figsize=(15,6))
#plt.subplot(1,2,1)
#imgplot = plt.imshow(img2)
#plt.subplot(1,2,2)
#imgplot = plt.imshow(out2)

out3 = model.predict_segmentation(
    inp ="image_semantic_segmentation/image/Nirvana_Nevermind.jpg",
    out_fname="image_semantic_segmentation/image/out.png"
)
img3 = mpimg.imread('image_semantic_segmentation/image/Nirvana_Nevermind.jpg')

#plt.figure(figsize=(15,6))
#plt.subplot(1,2,1)
#imgplot = plt.imshow(img3)
#plt.subplot(1,2,2)
#imgplot = plt.imshow(out3)

out4 = model.predict_segmentation(
    inp="image_semantic_segmentation/image/Sonic-Highways.jpg",
    out_fname="image_semantic_segmentation/image/out.png"
)
img4 = mpimg.imread('image_semantic_segmentation/image/Sonic-Highways.jpg')

#plt.figure(figsize=(15,6))
#plt.subplot(1,2,1)
#imgplot = plt.imshow(img4)
#plt.subplot(1,2,2)
#imgplot = plt.imshow(out4)

out.shape

out3.shape

###################################Preprocessing########################################


#######################################Resize########################################

# setting dim of the resize
height = 473
width = 473
dim = (width, height)
res = cv2.resize(img, dim, interpolation=cv2.INTER_LINEAR)
out_res = model.predict_segmentation(
    inp=res,
    out_fname="image_semantic_segmentation/image/out.png"
)
#plt.figure(figsize=(15,6))
#plt.subplot(1,2,1)
#imgplot = plt.imshow(res)
#plt.subplot(1,2,2)
#imgplot = plt.imshow(out_res)

# setting dim of the resize
height = 600
width = 600
dim = (width, height)
res1 = cv2.resize(img2, dim, interpolation=cv2.INTER_LINEAR)
out_res1 = model.predict_segmentation(
  inp=res1,
  out_fname="image_semantic_segmentation/image/out1.png"
)
#plt.figure(figsize=(15,6))
#plt.subplot(1,2,1)
#imgplot = plt.imshow(res1)
#plt.subplot(1,2,2)
#imgplot = plt.imshow(out_res1)

# setting dim of the resize
height = 600
width = 600
dim = (width, height)
res2 = cv2.resize(img3, dim, interpolation=cv2.INTER_LINEAR)
out_res2 = model.predict_segmentation(
  inp=res2,
  out_fname="image_semantic_segmentation/image/out2.png"
)
#plt.figure(figsize=(15,6))
#plt.subplot(1,2,1)
#imgplot = plt.imshow(res2)
#plt.subplot(1,2,2)
#imgplot = plt.imshow(out_res2)

# setting dim of the resize
height = 600
width = 600
dim = (width, height)
res3 = cv2.resize(img4, dim, interpolation=cv2.INTER_LINEAR)
out_res3 = model.predict_segmentation(
  inp=res3,
  out_fname="image_semantic_segmentation/image/out3.png"
)
#plt.figure(figsize=(15,6))
#plt.subplot(1,2,1)
#imgplot = plt.imshow(res3)
#plt.subplot(1,2,2)
#imgplot = plt.imshow(out_res3)

#########################################Denoise#####################################################

blur = cv2.GaussianBlur(res, (5, 5), 0)
out_blur = model.predict_segmentation(
    inp=blur,
    out_fname="image_semantic_segmentation/image/out_blur.png"
)
#plt.figure(figsize=(15,6))
#plt.subplot(1,2,1)
#imgplot = plt.imshow(blur)
#plt.subplot(1,2,2)
#imgplot = plt.imshow(out_blur)

blur1 = cv2.GaussianBlur(res1, (5, 5), 0)
out_blur1 = model.predict_segmentation(
    inp=blur1,
    out_fname="image_semantic_segmentation/image/out_blur1.png"
)
#plt.figure(figsize=(15,6))
#plt.subplot(1,2,1)
#imgplot = plt.imshow(blur1)
#plt.subplot(1,2,2)
#imgplot = plt.imshow(out_blur1)

blur2 = cv2.GaussianBlur(res2, (5, 5), 0)
out_blur2 = model.predict_segmentation(
    inp=blur2,
    out_fname="image_semantic_segmentation/image/out_blur2.png"
)
#plt.figure(figsize=(15,6))
#plt.subplot(1,2,1)
#imgplot = plt.imshow(blur2)
#plt.subplot(1,2,2)
#imgplot = plt.imshow(out_blur2)

blur3 = cv2.GaussianBlur(res3, (5, 5), 0)
out_blur3 = model.predict_segmentation(
    inp=blur3,
    out_fname="image_semantic_segmentation/image/out_blur3.png"
)
#plt.figure(figsize=(15,6))
#plt.subplot(1,2,1)
#imgplot = plt.imshow(blur3)
#plt.subplot(1,2,2)
#imgplot = plt.imshow(out_blur3)

###########################################Different results#######################################

plt.figure(figsize=(20,15))
plt.subplot(2,2,1)
imgplot = plt.imshow(img)
plt.subplot(2,2,2)
imgplot = plt.imshow(out)
plt.subplot(2,2,3)
imgplot = plt.imshow(out_res)
plt.subplot(2,2,4)
imgplot = plt.imshow(out_blur)

plt.figure(figsize=(20,15))
plt.subplot(2,2,1)
imgplot = plt.imshow(img2)
plt.subplot(2,2,2)
imgplot = plt.imshow(out2)
plt.subplot(2,2,3)
imgplot = plt.imshow(out_res1)
plt.subplot(2,2,4)
imgplot = plt.imshow(out_blur1)

plt.figure(figsize=(20,15))
plt.subplot(2,2,1)
imgplot = plt.imshow(img3)
plt.subplot(2,2,2)
imgplot = plt.imshow(out3)
plt.subplot(2,2,3)
imgplot = plt.imshow(out_res2)
plt.subplot(2,2,4)
imgplot = plt.imshow(out_blur2)

plt.figure(figsize=(20,15))
plt.subplot(2,2,1)
imgplot = plt.imshow(img4)
plt.subplot(2,2,2)
imgplot = plt.imshow(out4)
plt.subplot(2,2,3)
imgplot = plt.imshow(out_res3)
plt.subplot(2,2,4)
imgplot = plt.imshow(out_blur3)
plt.show()
