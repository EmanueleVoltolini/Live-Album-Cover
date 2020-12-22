class Brush{

  float radius;
  PVector pos, vel, acc;
  float max_vel = 1.9;
  float lifespan;
  float current_lifespan;
  float rand;
  color col;
  ArrayList<PVector> pos_history = new ArrayList<PVector>();
  ArrayList<Float> rand_history = new ArrayList<Float>();

  Brush(PVector pos, float radius, float lifespan){
    this.pos= pos.copy();
    this.vel = new PVector();
    this.acc = new PVector();
    this.lifespan=lifespan;
    this.current_lifespan = lifespan;
    this.radius = radius;
    this.rand = random(0,1);
  }

  void update(){
    this.pos_history.add(this.pos.copy());
    this.rand_history.add(random(0,1));
    this.vel.add(this.acc);
    if(this.vel.mag() > this.max_vel){
      this.vel.mult(this.max_vel/this.vel.mag());
    }
    this.pos.add(this.vel);
    this.acc.mult(0);
  }
  
  void applyForce(PVector force){    
    this.acc.add(force);    
  }
  
  float getLifePercent(){
    return (this.lifespan - this.current_lifespan) / this.lifespan;
  }
  
  void draw(){
    
    for(int i=this.pos_history.size()-1; i>=0; i--){
      PVector pos = this.pos_history.get(i);
      Float rand = this.rand_history.get(i);
      color col = imgManager.getCoverPxColor(pos);
      
      float alpha;
      float percentage = getLifePercent();
      if(percentage > 0.5){
        alpha = (2-2*percentage);
      }else{
        alpha = percentage*2;
      }
      
      
      //color modifications
      
      
     
      noStroke();
      fill(col, alpha * (float)i / this.pos_history.size());
      ellipse(pos.x*(1+(rand-0.5)*0.001), pos.y*(1+(rand-0.5)*0.001), map(mouseX, 0, width, 2, this.radius*10*(1+(rand-0.5)*0.2)), map(mouseY, 0, height, 2, this.radius*10*(1+(rand-0.5)*0.2)));
      
    }
  }

  boolean isDead(){
    return this.current_lifespan<=0;
  }
}
