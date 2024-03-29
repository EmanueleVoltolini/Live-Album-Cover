class Brush{

  float radius;
  PVector pos, vel, acc;
  float max_vel = 9;
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
    this.max_vel = map(pow(audioManager.getRMS(), 3), 0, 1, 1, 10) + max(0, (10 - 15*audioManager.getTimeFromLastBeat()));

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
      
      
     int n_steps = 3;
     for(int j = 0; j < n_steps; j++){
      noStroke();
      fill(col, alpha * (float)i / this.pos_history.size() * (0.3 + 0.7*pow(audioManager.getRMS(), 4)) * float(j)/n_steps);
      
      ellipse(
        pos.x*(1+(rand-0.5)*0.01),
        pos.y*(1+(rand-0.5)*0.01),
        map(pow(audioManager.getRMS(),2), 0, 1, 5, this.radius*10*(1+(rand-0.5)*0.2)) * (1-float(j)/n_steps),
        map(pow(audioManager.getRMS(),2), 0, 1, 5, this.radius*10*(1+(rand-0.5)*0.2)) * (1-float(j)/n_steps)
      );
      
     }
    }
  }

  boolean isDead(){
    return this.current_lifespan<=0;
  }
}
