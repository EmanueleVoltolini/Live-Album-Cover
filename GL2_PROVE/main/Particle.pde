
class Particle{
  PVector location, velocity, acceleration;
  float radius_circle, lifespan;
  color col;
  PImage img;
  float rand;
  Particle(PVector location, float radius_circle, float lifespan){
    Img.loadPixels();
    this.location= location.copy();
    this.velocity = new PVector();
    this.acceleration = new PVector();
    this.radius_circle=radius_circle;
    this.lifespan=lifespan;
    int x = int(location.x);
    int y = int(location.y);
    color c = Img.get(x,y);
    this.col = c;
    this.rand = random(0,1);
  }
  void planning(){    
    this.velocity.add(this.acceleration);
    this.location.add(this.velocity);
    this.acceleration.mult(0);
  }
  
  void applyForce(PVector force){    
    this.acceleration.add(force);
    
  }
  void action(color c){
    float radius;
    for (int i = 0; i < 3; i = i+1) {
      this.planning(); 
      fill(c, this.lifespan); noStroke();
      if(frameCount>1200){
        radius = map(pow(audioManager.getRMS(),3), 0, 1, 3, this.radius_circle*5*(1+(rand-0.5)*0));
      }else{
        radius = map(pow(audioManager.getRMS(),3), 0, 1, 5, this.radius_circle*5*(1+(rand-0.5)*0));
      }
      ellipse(this.location.x, this.location.y, radius*random(0.7,1.3), radius*random(0.7,1.3));
    }
  }
  
  boolean isDead(){
    if ((this.lifespan<=0) || (this.location.x<0 || this.location.x>600) || (this.location.y<0 || this.location.y>600)){
      return true;
    }
    else{
      return false;
    }
  }
}
