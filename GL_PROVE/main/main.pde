/*import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress remoteLoc;*/
int size = 600;
int frameRate = 40;

import processing.opengl.*;
import processing.sound.*;
SoundFile file;

BrushSystem brushSystem;
ImgManager imgManager;
AudioManager audioManager;
ImgObject imgObject;
ObjectList objectList;

void setup() {
  file = new SoundFile(this, "/../../data/song3.mp3");
  size(600, 600, P2D);
  frameRate(frameRate);
  /*
  oscP5 = new OscP5(this,9999);
  remoteLoc = new NetAddress("127.0.0.1", 9999);
 
 */ 
  
  imgManager = new ImgManager();
  imgObject = new ImgObject();
  brushSystem = new BrushSystem();
  audioManager = new AudioManager();
  
  imgObject.find_objects();
  objectList = new ObjectList(imgObject);
  
  imageMode(CENTER);
  noStroke();
  background(0);
  colorMode(HSB, 1);
  //imgManager.drawCover();
}


void draw() {
  //clear();
  //imgManager.drawCover();
  objectList.draw();
  //brushSystem.update();
  //brushSystem.draw();
}

/*
void keyPressed() {
  if (key == ' ') {
    //brushSystem.forcePattern.changePattern();
  }
}
*/

 enum ForcePatternType {
  ATTRACT,
  RADIAL_EXT,
  RADIAL_INT,
  CIRCLE_RIGHT,
  CIRCLE_LEFT,
  RANDOM
}
