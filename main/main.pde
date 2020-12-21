import oscP5.*;
import netP5.*;

OscP5 oscP5;
int size = 600;
int frameRate = 60;


BrushSystem brushSystem;
ImgManager imgManager;
FeatureManager featureManager;

void setup() {
  size(600, 600);
  frameRate(frameRate);
  oscP5 = new OscP5(this,9999);
  imgManager = new ImgManager();
  featureManager = new FeatureManager();
  brushSystem = new BrushSystem();
  
  imageMode(CENTER);
  noStroke();
  background(0);
  colorMode(HSB, 1);
}

void draw() {
  imgManager.drawCover();
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
