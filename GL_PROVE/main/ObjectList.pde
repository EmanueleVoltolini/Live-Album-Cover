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
  void draw(){
    for (int p=0; p<this.nObj; p++) {  
      this.systems.get(p).update();
      this.systems.get(p).draw();
      //imgObject.drawCentroids();
      //print(this.systems.get(p).forcePattern.type);
    }
  }
  
}
