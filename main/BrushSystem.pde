class BrushSystem {

  ArrayList<Brush> particles;
  PVector origin;
  int n_brushes = 500;
  ForcePattern forcePattern;


  BrushSystem() {
    this.particles = new ArrayList<Brush>();
    this.forcePattern = new ForcePattern();
    this.origin=new PVector(width/2, height/2);
    for (int p=0; p<this.n_brushes; p++) {
      this.addParticle();
    }
  }

  void addParticle() {
    PVector pos = new PVector(random(0, size), random(0, size));
    float lifespan = random(0.2, 1.2);
    float radius = random(1, 2);
    this.particles.add(new Brush(pos, radius, lifespan));
  }

  void update() {
    Brush p;
    for (int i=0; i<this.particles.size(); i++) {
      p=this.particles.get(i);
      PVector force = forcePattern.getForce(p.pos, p.vel, this.origin);
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
