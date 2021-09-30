class ParticleSystem{
  ArrayList<Particle> particles;
  int n_particles;
  PVector origin;
  PImage img_sys= loadImage("abbey_road.jpg");
  
  ParticleSystem(PVector centre, int percentage) {
    img_sys.loadPixels();
    this.n_particles=100*percentage*imgObject.nObj/(size*size);
    this.particles = new ArrayList<Particle>();
    //this.origin=new PVector(width/2, height/2);
    this.origin=new PVector(centre.x, centre.y);

    for(int p=0; p<n_particles; p++){
       addParticle();
  }

  }

    void addParticle(){
    this.particles.add(new Particle(this.origin, random(1,5), random(200,255)));   
  }
  
  void action(boolean d){
    Particle p;
    for(int i=this.particles.size()-1; i>=0; i--){
      p=this.particles.get(i);
      int x = int(p.location.x/size*img_sys.width);
      int y = int(p.location.y/size*img_sys.height);
      float plus = random(0,0.15);
      float hu = hue(img_sys.get(x, y))+plus;
      float sat = saturation(img_sys.get(x, y))+plus;
      //float bri = brightness(img_sys.get(x, y))+plus;
      float bri = beat_coloration()*brightness(img_sys.get(x, y));
      if(d){bri = brightness(img_sys.get(x, y))+plus;}
      color c_im = color(hu*random(0.9,1.1), sat, bri);
      //print(c_im);
//      if (c_im == color(255,242,0,255)){
//        red = red(c_im)* random(0.3,1.2);
//        green = green(c_im)*random(0.3,1.2);
//        blue = blue(c_im)* random(0.3,1.2);      
        p.applyForce(new PVector(random(-0.2, 0.2), random(-0.2,0.2)));
        //p.applyForce(new PVector(random(-0.4, 0.4), random(0.1,0.8)));
        p.action(c_im);
      //}
      p.lifespan-=5;
      noStroke();
      if(p.isDead()){
         particles.remove(i);
         this.addParticle();
      }
    }
   }

}
