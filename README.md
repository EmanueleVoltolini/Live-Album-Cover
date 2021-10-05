# Live-Album-Cover
## The main idea 
When we listen to a music album, we cannot avoid watching and examining its cover.
Unfortunately, listening through the album, switching from song to song, the cover is static and doesn’t add any more information or artistic novelty to the audience experience. From this fact, we developed the idea to take the album cover and bring it alive, making it change with the music, following in real time some feature extracted from the song itself. </br>
The image will be segmented using AI algorithms, and deconstructed in a moving particle system, in which colours, velocity, brightness, ecc. reflect changes in music.
With help of audio segmentation, these visual effects will follow the mood of every single song.</br>
For the implementation, we will use Python for feature extraction and Image Semantic Segmentation, Processing will manage the graphical part.

# How to use Live Album Cover 
## Structure 
The code is divided in:
* Python 
  * Image Semantic Segmentation
  * Feature extraction
* Processing
  * Visual effects

## Image semantic segmentation
Fist thing to do is the segmentation of the cover image. In order to do that you need to insert the choosen cover in the ***data*** folder, than you simply insert the name of the file in the ***Imgae_semantic_segm.py*** file: </br>
~~~python
################## insert here the name of the cover you want to segment #############
song_name = "muse"
######################################################################################
~~~
The segmentation is based on three pretrained model to choose from:
~~~python
model = pspnet_50_ADE_20K() # load the pretrained model trained on ADE20k dataset

model1 = pspnet_101_cityscapes() # load the pretrained model trained on Cityscapes dataset

model2 = pspnet_101_voc12() # load the pretrained model trained on Pascal VOC 2012 dataset
~~~ 
These models deal with the segmentation, the results will be not so accurate as it would be necessary to train the network with an album cover dataset.</br>
Here there are two examples: 
original          |  segmented
:-------------------------:|:-------------------------:
![](/Readme_images/original1.jpg)  |  ![](/Readme_images/segmented1.png)
![](/Readme_images/original2.jpg)  |  ![](/Readme_images/segmented2.png)
</br>
As we can see the results vary a lot from one cover to another, this will affect a lot the overall visual effect.

## Features extraction
First we need to load the choosen song in the ***data*** folder, than as we have done for the Image segmentation we need to insert the name of the file in the ***Feature_extraction.py*** file: </br>
~~~python
####### insert here the name of the cover from which you want to extract the features #######
song_name = "The Beatles - Come Together"
#############################################################################################
~~~
The features extracted are:
* ZCR (zero crossing rate)
* Spectral Centroid
* Spectral Decrease
* Beat (beat tracker)
* RMS
* Spectral Roll off
</br>
All these features are stored in a _.json_ file that will be loaded in _Processing_ workspace.

## Processing 
Processing deals with the graphical effects. </br>
The main implemented visual effects are based on particle systems, which properties are controlled by the audio extracted features. </br>
For example the dimension of the particles is determined by the RMS, or their colors are controlled by the Spectral Centroid and Spectral Decrease values. </br>
The only request in order to run properly the code, is to open the ***main.pde*** file and insert the name of the cover you want to animate and the right audio extension of the song file (*.wav* or *.mp3*):
~~~java
String song_name = "savant";

String song_path = "/../../data/" + song_name + ".wav";
~~~
Here it is an examples of the changes in the cover:
original          |  processed
:-------------------------:|:-------------------------:
![](/Readme_images/original1.jpg)  |  ![](/Readme_images/processed.jpg)
![](/Readme_images/processed1.jpg)  
## Tips 
If you feel particular inspired by the cover changes, click the spacebar to remain in that configuration ;)
# Who is Live Album Cover
JL (Jack Long)
O (Orland)
G (Guido - the one who came up with the idea)
# Have fun!
