ParticleSystem ps;
Painter p;
int size = 600;
int Nparticles=300;
PImage img;
boolean pain = true;
void setup(){
  size(600,600);
  img = loadImage("squares.png");
  ps=new ParticleSystem();
  p = new Painter();
  for(int p=0; p<Nparticles; p++){
    ps.addParticle();
  }
  frameRate(60);
  imageMode(CENTER);
  noStroke();
  background(0);
}

void draw(){
//  imageMode(CENTER);
//  image(img,300,300,600,600);
  if(pain){
    float x = random(1,600);
    float y = random(1,600);
    ps.origin=new PVector(x, y);
    ps.action();
    p.paint();
  }else{
    background(0);
  }
}
void mouseClicked(){
  pain = !pain;
  frameCount = 0;
}
