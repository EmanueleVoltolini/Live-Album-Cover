class ObjectList{
  ArrayList<BrushSystemO> systems;
  ImgObject imgObject;
  ArrayList<PVector> centroidList;
  int nObj;
  
  ObjectList(ImgObject imgObject){
    nObj = imgObject.nObj;
    centroidList = imgObject.centroid;
    this.systems = new ArrayList<BrushSystemO>();
    for (int p=0; p<this.nObj; p++) {
      this.addSystemO(centroidList.get(p), imgObject.count.get(p)); 
    }
  }
  void addSystemO(PVector p, int percentage) {
    this.systems.add(new BrushSystemO(p, percentage));
  } 
int a=0;
int b=0;
int c=0;
  void draw(){
    if(frameCount%(frameRate*3)==0||c==0){
      a = floor(random(0, this.nObj));
      b = floor(random(0, this.nObj));
      c++;
    }
    this.systems.get(a).update();
    this.systems.get(a).draw();
    this.systems.get(b).update();
    this.systems.get(b).draw();
    /*
    for (int p=0; p<this.nObj; p++) {  
      this.systems.get(p).update();
      this.systems.get(p).draw();
      //imgObject.drawCentroids();
      //print(this.systems.get(p).forcePattern.type);
      
    }*/
  }
  
}
