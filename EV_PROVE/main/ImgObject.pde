class ImgObject {
  PImage img_obj;
  ArrayList <PVector> centroid = new ArrayList <PVector> ();
  //IntList colors  =  new IntList ();
  ArrayList <Colorobj> colors = new ArrayList <Colorobj> ();
  IntList count = new  IntList ();
  color[] colors_arr;
  int a=0;
  int b=0;
  int nObj=0;
  
  ImgObject(){
    img_obj = loadImage("out3.png");
    img_obj.loadPixels();  
    //print(img_obj.width);
  }
 color getcolor(int a){
   return this.colors.get(a).c;
 }
  void find_objects(){
    PVector pix = new PVector();   
    pix.x=1;
    pix.y=1;

    this.colors.add(new Colorobj(this.img_obj.pixels[int(pix.y)*img_obj.width+int(pix.x)]));
    this.centroid.add(pix);
    this.count.append(0);
    
    boolean exist = false;
    for (int i=0; i<=size-1; i++){
     for(int j=0; j<=size-1; j++){
       pix.x = i;        
       pix.y = j;
       
       color c = this.img_obj.pixels[int(pix.y)*img_obj.width+int(pix.x)];
       exist= false; 
       for (int k= this.colors.size()-1; k>=0; k--){
         if (c == this.colors.get(k).c){
           exist= true; 
           this.centroid.set(k, PVector.add(this.centroid.get(k),pix)); 
           this.count.increment(k); 
           a++;
           break;
         }
       }
       //print (j);
       if(exist==false){
         b++;
         this.colors.add(new Colorobj(c));
         this.centroid.add(pix); 
         this.count.append(1);
       } 
     }
    }
    
    for (int k= this.colors.size()-1; k>=0; k--){
      int cx = int (this.centroid.get(k).x);
      int cy = int (this.centroid.get(k).y);    
      PVector cxy = new PVector(cx, cy);
      cxy = cxy.mult(int((cxy.mag()/this.count.get(k)))/cxy.mag());
      this.centroid.set(k, cxy);
    }
  this.nObj = this.colors.size();
  print(this.nObj);
  //print(this.centroid);
  print(this.count);
  //print(colors_arr.length);
  //print(a);
  //print(colors.get(0).c);
  }
  
  void drawCentroids(){
    for (int k= this.nObj-1; k>=0; k--){
      noStroke();
      fill(255, 150, 150);
      
      ellipse(
        this.centroid.get(k).x,
        this.centroid.get(k).y,
        5,
        5
      );
    }
  }
  
}  
