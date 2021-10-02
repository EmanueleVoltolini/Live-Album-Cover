class ParticleSystem{
  ArrayList<Particle> particles;
  PVector origin;
  PImage img;
  
  ParticleSystem(){
    this.particles = new ArrayList<Particle>();
    //this.origin=new PVector(width/2, height/2);
    this.origin=new PVector(450, 150);

    img = loadImage("squares.png");
  }
  ParticleSystem(PVector origin){
    this.particles = new ArrayList<Particle>();
    this.origin=origin.copy();
  }
  void addParticle(){
    color c = color(0,0,0);
    this.particles.add(new Particle(this.origin, random(1,7), random(200,255),c));   
  }
    void addParticle(color c){
    this.particles.add(new Particle(this.origin, random(1,7), random(200,255),c));   
  }
  
  void action(){
    float a = 0;
    float b = 0;
    Particle p;
    for(int i=this.particles.size()-1; i>=0; i--){
      p=this.particles.get(i);
      int x = int(p.location.x/size*img.width);
      int y = int(p.location.y/size*img.height);
      float red = red(img.get(x, y));
      float green = green(img.get(x, y));
      float blue = blue(img.get(x, y));
      color c_im = color(red, green, blue,255);
      //print(c_im);
      if (c_im == color(255,242,0,255)){
//        red = red(c_im)* random(0.3,1.2);
//        green = green(c_im)*random(0.3,1.2);
//        blue = blue(c_im)* random(0.3,1.2);
        color c1 = color(red,green,blue);      
        p.applyForce(new PVector(random(-2, 2), random(-2,2)));
        //p.applyForce(new PVector(random(-0.4, 0.4), random(0.1,0.8)));
        if(frameCount < 60){
          a = random(7,25);
          b = random(7,25);
        }else if(frameCount < 300){
          a = random(5,20);
          b = random(5,20);
        }else if(frameCount < 600){
          a = random(3,15);
          b = random(3,15);
        }else{
          a = random(1,10);
          b = random(1,10);
        }
        p.action(c1,a,b);
      }
      p.lifespan-=30;
      noStroke();
      if(p.isDead()){
         particles.remove(i);
         this.addParticle();
      }
    }
    
  }

}
