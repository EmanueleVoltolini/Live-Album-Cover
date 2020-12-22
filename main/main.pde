import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress remoteLoc;
int size = 600;
int frameRate = 40;


BrushSystem brushSystem;
ImgManager imgManager;
FeatureManager featureManager;

void setup() {
  size(600, 600);
  frameRate(frameRate);
  oscP5 = new OscP5(this,9999);
  remoteLoc = new NetAddress("127.0.0.1", 9999);
  imgManager = new ImgManager();
  featureManager = new FeatureManager();
  brushSystem = new BrushSystem();
  
  imageMode(CENTER);
  noStroke();
  background(0);
  colorMode(HSB, 1);
}

void draw() {
  clear();
  //imgManager.drawCover();
  brushSystem.update();
  brushSystem.draw();
}



void oscEvent(OscMessage message) {
  if(message.checkAddrPattern("/featureUpdate") == true) {
    float feat = message.get(0).floatValue();
    featureManager.energy = feat;
    return;
  }
}

enum ForcePatternType {
  RADIAL_EXT,
  RADIAL_INT,
  CIRCLE_RIGHT,
  CIRCLE_LEFT,
  RANDOM
}
