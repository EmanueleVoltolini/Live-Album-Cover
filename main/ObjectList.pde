class ObjectList{
  ArrayList<BrushSystemO> systems;
  ArrayList<ParticleSystem> sys;
  ArrayList<Painter> paint;
  ImgObject imgObject;
  ArrayList<PVector> centroidList;
  int nObj;
  int rand;
  int rand1;
  //float duration_beat;
  
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
    /*int i;
    float aa;
    aa=0;
    for (i=0; i<=beats.size()-1; i++){
      aa=aa+beats.getFloat(i+1)-beats.getFloat(i);
    }
    this.duration_beat=aa/i;*/
  }
  
  void addSystemO(PVector p, int percentage) {
    this.systems.add(new BrushSystemO(p, percentage));
    this.sys.add(new ParticleSystem(p, percentage));
    this.paint.add(new Painter());
  } 
  
int a=0;
int b=0;
int c=0;
boolean d=true;
boolean f=true;
float duration_beat =audioManager.beat_duration();
  void draw(){
    if(c==0){print("||||"+int(frameRate*4*duration_beat)+"||||");}
    if (frameCount%int(frameRate*4*duration_beat)==0){
      d=true;
    }
    
    if(f||c==0){          //after 3 second change the segments to wich apply the effects
      a = floor(random(0, this.nObj));
      b = floor(random(0, this.nObj));
      rand = int(random(0,3));
      rand1 = int(random(0,3));
      c=1;
      f=false;
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
    if (d){f=true;}
    d=false;
  }
  
}
