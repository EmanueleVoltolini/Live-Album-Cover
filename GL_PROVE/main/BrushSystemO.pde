class BrushSystemO {

  ArrayList<Brush> particles;
  PVector origin;
  int n_brushes;
  ForcePattern forcePattern;
  PVector centroid;

  BrushSystemO(PVector centro, int percentage) {
    //this.n_brushes=1000*percentage*imgObject.nObj/(size*size);
    this.n_brushes=1000;
    centroid = centro;
    this.particles = new ArrayList<Brush>();
    this.forcePattern = new ForcePattern();
    int fpt = int(random(-0.4, 4.4));
    print(fpt);
    if(fpt==0){this.forcePattern.type = ForcePatternType.CIRCLE_LEFT;}
    else if(fpt==1) {this.forcePattern.type = ForcePatternType.CIRCLE_RIGHT;}
    else if(fpt==2) {this.forcePattern.type = ForcePatternType.RADIAL_EXT;}
    else if(fpt==3) {this.forcePattern.type = ForcePatternType.ATTRACT;}
    else if(fpt==4) {this.forcePattern.type = ForcePatternType.RADIAL_INT;}
    this.origin=centroid;
    for (int p=0; p<this.n_brushes; p++) {
      this.addParticle();
    }
  }

  void addParticle() {
    PVector pos = new PVector(random(0, size), random(0, size));
    //PVector pos = this.centroid;
    for (int i=0; i<100; i++){
      if(imgObject.img_obj.pixels[int(pos.y)*imgObject.img_obj.width+int(pos.x)] !=(imgObject.img_obj.pixels[int(origin.y)*imgObject.img_obj.width+int(origin.x)])){
        pos = new PVector(random(0, size), random(0, size));
      }
      else  {break;}
    }
    float lifespan = random(0.1, 0.5);
    float radius = random(1, 7);
    //radius = -5*radius*audioManager.getSpecDec();
    this.particles.add(new Brush(pos, radius, lifespan));
  }

  void update() {
    Brush p;
    for (int i=0; i<this.particles.size(); i++) {
      p=this.particles.get(i);
      //if(p.pos.x<0||p.pos.y<0){print(p.pos);}
      PVector force = forcePattern.getForce(p.pos.copy(), p.vel.copy(), this.origin.copy());
      //if(p.Verify(p.pos.add(force), origin)){force=origin.sub(p.pos);}
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
      if (p.isDead()||p.outBoundaries()) {
        particles.remove(i);
        this.addParticle();
      }
    }
  }
}
