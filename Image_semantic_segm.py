
####################Image Semantic Segmentation########################

import os
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import cv2
from keras_segmentation.pretrained  import pspnet_50_ADE_20K , pspnet_101_cityscapes, pspnet_101_voc12
from pathlib import Path

################## insert here the name of the cover you want to segment ###############
song_name = "Florida"
######################################################################################

# setting dim of the resize
height = 600
width = 600
dim = (width, height)

extensions = ['jpg','png','jpeg']
exist_check = False

model = pspnet_50_ADE_20K() # load the pretrained model trained on ADE20k dataset

model1 = pspnet_101_cityscapes() # load the pretrained model trained on Cityscapes dataset

model2 = pspnet_101_voc12() # load the pretrained model trained on Pascal VOC 2012 dataset

# load any of the 3 pretrained models
# The first pre-trained model is the best for our task
'''
out = model.predict_segmentation(
    inp="image_semantic_segmentation/image/"+song_name+".jpg",
    #out_fname="data/" + song_name + "_segm.png"
)
'''
for i in range(len(extensions)):
    my_file = Path("data/" + song_name + "." + extensions[i])
    if my_file.is_file():
        img = mpimg.imread("data/" + song_name + "." + extensions[i])
        exist_check = True
        res = cv2.resize(img, dim, interpolation=cv2.INTER_LINEAR)
        mpimg.imsave("data/" + song_name + ".jpg",res)
if not(exist_check):
    print("The image doesn't exist or the format is not supported")
else:
    print("Image load :)")

####################################### Segmentation ########################################


out_res = model.predict_segmentation(
    inp=res,
    out_fname="data/" + song_name + "_segm.png"
)

#########################################Denoise#####################################################
'''
blur = cv2.GaussianBlur(res, (5, 5), 0)
out_blur = model.predict_segmentation(
    inp=blur,
    out_fname="data/" + song_name + "_segm.png"
)
'''
###########################################Different results#######################################

plt.figure(figsize=(20,15))
plt.subplot(2,2,1)
imgplot = plt.imshow(img)
plt.subplot(2,2,2)
imgplot = plt.imshow(out_res)
plt.subplot(2,2,3)

# %%
