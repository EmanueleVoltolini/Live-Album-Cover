
int size = 600;                                          //Define the size of the display
int frameRate = 60; //Define the frame-rate
boolean loop = true;

import processing.opengl.*;                             //Importing the library for the GPU rendering
import processing.sound.*;                             //Importing the library for the audio managment
SoundFile file;                                        //Create the Soundfile player
PImage Img;
//Defining the used class
ImgManager imgManager;                              
AudioManager audioManager;
ImgObject imgObject;
ObjectList objectList;
int counter = 0;

void setup() {
  Img =  loadImage("abbey_road.jpg");
  file = new SoundFile(this, "/../../data/The Beatles - Come Together.mp3");  //Import the song we want 
  size(600, 600, P2D);                                  //Define the dimension of the window and the use of GPU rendering
  frameRate(frameRate);

  //call the contructurs of our class
  imgManager = new ImgManager();
  imgObject = new ImgObject();
  audioManager = new AudioManager();
  
  imgObject.find_objects();                          //Calculate the centroid of each segment of the image(the segmentation is done by a previous python code)
  objectList = new ObjectList(imgObject);            //Inizialise the array of obj in the cover(the segmentation is done by a previous python code)
  
  imageMode(CENTER);                              
  noStroke();
  background(0);
  colorMode(HSB, 1);
  //imgManager.drawCover();
}


void draw() {
  if(counter==0){
    image(Img, size/2, size/2, size, size);
    counter+=1;
  }
  //clear();
  //imgManager.drawCover();
  objectList.draw();                            
  //brushSystem.update();
  //brushSystem.draw();
}


void keyPressed() {
  if (key == ' ' && loop) {
    noLoop();
    loop = false;
  }else{
    loop();
    loop= true;
  }
}


 enum ForcePatternType {
  ATTRACT,
  RADIAL_EXT,
  RADIAL_INT,
  CIRCLE_RIGHT,
  CIRCLE_LEFT,
  RANDOM
}
