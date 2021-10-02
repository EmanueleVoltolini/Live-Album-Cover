
class Particle{
  PVector location, velocity, acceleration;
  float radius_circle, lifespan;
  color col;
  PImage img;
  Particle(PVector location, float radius_circle, float lifespan, color c){
    this.location= location.copy();
    this.velocity = new PVector();
    this.acceleration = new PVector();
    this.radius_circle=radius_circle;
    this.lifespan=lifespan;
    this.col = c;
  }
  void planning(){    
    this.velocity.add(this.acceleration);
    this.location.add(this.velocity);
    this.acceleration.mult(0);
  }
  
  void applyForce(PVector force){    
    this.acceleration.add(force);
    
  }
  void action(color c, float a, float b){
    for (int i = 0; i < 3; i = i+1) {
      this.planning(); 
      fill(c, this.lifespan);
      noStroke();
      ellipse(this.location.x, this.location.y, a, b);
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
