int size = 700;
int frame_rate = 30;


PImage img_cover;
BrushSystem brush_system;

void setup() {
  size(700, 700);
  frameRate(frame_rate);
  
  img_cover = loadImage("cover2.jpg");
  imageMode(CENTER);
  noStroke();
  background(0);
  
  brush_system = new BrushSystem();
  colorMode(HSB, 1);
  
}

void draw() {
  image(img_cover, size/2, size/2, size, size);
  brush_system.update();
  brush_system.draw();
}
