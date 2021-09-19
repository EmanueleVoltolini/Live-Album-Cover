class BrushSystemO {

  ArrayList<Brush> particles;
  PVector origin;
  int n_brushes = 500;
  ForcePattern forcePattern;
  PVector centroid;

  BrushSystemO(PVector centro) {
    centroid = centro;
    this.particles = new ArrayList<Brush>();
    this.forcePattern = new ForcePattern();
    this.origin=centroid;
    for (int p=0; p<this.n_brushes; p++) {
      this.addParticle();
    }
  }

  void addParticle() {
    PVector pos = new PVector(random(0, size), random(0, size));
    //PVector pos = this.centroid;
    float lifespan = random(0.1, 0.5);
    float radius = random(1, 7);
    this.particles.add(new Brush(pos, radius, lifespan));
  }

  void update() {
    Brush p;
    for (int i=0; i<this.particles.size(); i++) {
      p=this.particles.get(i);
      //if(p.pos.x<0||p.pos.y<0){print(p.pos);}
      PVector force = forcePattern.getForce(p.pos.copy(), p.vel.copy(), this.origin.copy());
      if(p.Verify(force, origin)){force=origin;}
      p.applyForce(force);
      p.update();
    }
  }

  void draw() { 
    Brush p;
    for (int i = this.particles.size() - 1; i >= 0; i--) {
      p=this.particles.get(i);
      p.draw();
      p.current_lifespan -= 1.0/frameRate;
      if (p.isDead()) {
        particles.remove(i);
        this.addParticle();
      }
    }
  }
}
