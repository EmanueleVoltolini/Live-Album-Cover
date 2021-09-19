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
      this.addSystemO(centroidList.get(p)); 
    }
  }
  void addSystemO(PVector p) {
    this.systems.add(new BrushSystemO(p));
  }  
  void draw(){
    for (int p=0; p<this.nObj; p++) {  
      this.systems.get(p).update();
      this.systems.get(p).draw();
      //this.imgObject.drawCentroids();
      //print(this.systems.get(p).forcePattern.type);
    }
  }
  
}
