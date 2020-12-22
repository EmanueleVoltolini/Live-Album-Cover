import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress remoteLoc;
int size = 600;
int frameRate = 40;
  
import processing.sound.*;
SoundFile file;

BrushSystem brushSystem;
ImgManager imgManager;
AudioManager audioManager;

void setup() {
  size(600, 600);
  frameRate(frameRate);
  
  oscP5 = new OscP5(this,9999);
  remoteLoc = new NetAddress("127.0.0.1", 9999);
  
  file = new SoundFile(this, "/../data/song.mp3");
  
  imgManager = new ImgManager();
  brushSystem = new BrushSystem();
  audioManager = new AudioManager();
  
  imageMode(CENTER);
  noStroke();
  background(0);
  colorMode(HSB, 1);
}

void draw() {
  clear();
  imgManager.drawCover();
  brushSystem.update();
  brushSystem.draw();
}


void keyPressed() {
  if (key == ' ') {
    brushSystem.forcePattern.changePattern();
  }
}

enum ForcePatternType {
  RADIAL_EXT,
  RADIAL_INT,
  CIRCLE_RIGHT,
  CIRCLE_LEFT,
  RANDOM
}
