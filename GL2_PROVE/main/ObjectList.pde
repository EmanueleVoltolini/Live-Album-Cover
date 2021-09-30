class ObjectList{
  ArrayList<BrushSystemO> systems;
  ArrayList<ParticleSystem> sys;
  ArrayList<Painter> paint;
  ImgObject imgObject;
  ArrayList<PVector> centroidList;
  int nObj;
  int rand;
  int rand1;
  
  ObjectList(ImgObject imObject){
    imgObject = imObject;
    nObj = imObject.nObj;
    centroidList = imObject.centroid;
    this.systems = new ArrayList<BrushSystemO>();
    this.sys = new ArrayList<ParticleSystem>();
    this.paint = new ArrayList<Painter>();
    for (int p=0; p<this.nObj; p++) {
      this.addSystemO(centroidList.get(p), imObject.count.get(p)); 
    }
  }
  void addSystemO(PVector p, int percentage) {
    this.systems.add(new BrushSystemO(p, percentage));
    this.sys.add(new ParticleSystem(p, percentage));
    this.paint.add(new Painter());
  } 
  
int a=0;
int b=0;
int c=0;
boolean d=false;
  void draw(){
    if (frameCount%(frameRate*3)==0){
      d=true;
      
    }
    if(d||c==0){          //after 3 second change the segments to wich apply the effects
      a = floor(random(0, this.nObj));
      b = floor(random(0, this.nObj));
      rand = int(random(0,3));
      rand1 = int(random(0,3));
      c=1;
    }
    //rand = 2;
    //rand1=rand;
    if(rand==0){
      this.sys.get(a).action(d);
    }else if(rand==2){
      this.systems.get(a).update();
      this.systems.get(a).draw(d);
    }
    if(rand1==0){
      this.sys.get(b).action(d);
    }else if(rand1==2){
      this.systems.get(b).update();
      this.systems.get(b).draw(d);
    }
    if(rand1==1){
      this.paint.get(b).painting(this.imgObject.colors.get(b).c);
    }
    if(rand==1){
      this.paint.get(a).painting(this.imgObject.colors.get(a).c);
    }
    /*
    for (int p=0; p<this.nObj; p++) {  
      this.systems.get(p).update();
      this.systems.get(p).draw();
      //imgObject.drawCentroids();
      //print(this.systems.get(p).forcePattern.type);
      
    }*/
    d=false;
  }
  
}
