class ImgObject {
  PImage img_obj;
  ArrayList <PVector> centroid = new ArrayList <PVector> ();
  //IntList colors  =  new IntList ();
  ArrayList <Colorobj> colors = new ArrayList <Colorobj> ();
  IntList count = new  IntList ();
  //color [] colors_arr;
  int a=0;
  int b=0;
  
  ImgObject(){
    img_obj = loadImage("/../../squares.png");
    img_obj.loadPixels();  
    print(img_obj.width);
}
//  color getCoverPxColor(PVector pos){
//   return img_obj.get(int(pos.x/size*img_obj.width), int(pos.y/size*img_obj.height));
 // }
  
  void find_objects(){
    PVector pix = new PVector();
    //pix.x=int(1/size*img_obj.width);
    //pix.y=int(1/size*img_obj.height);
    //this.colors.append(img_obj.get(int(pix.x), int(pix.y)));
    
    pix.x=1;
    pix.y=1;
    //Colorobj col;
    //col = Colorobj(color(this.getCoverPxColor(pix)))
    //this.colors.append(this.img_obj.get(int(pix.x/size*img_obj.width), int(pix.y/size*img_obj.height)));
    this.colors.add(new Colorobj(this.img_obj.pixels[int(pix.y)*img_obj.width+int(pix.x)]));
    this.centroid.add(pix);
    this.count.append(0);
    //color[] colors_arr = this.colors.array();
    boolean exist = false;
    for (int i=0; i<=size-1; i++){
     for(int j=0; j<=size-1; j++){
       pix.x = i; // int(i/size*img_obj.width);       
       pix.y = j; //int(j/size*img_obj.height);
       //color c = this.getCoverPxColor(pix);
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
         //colors_arr = this.colors.array();
         this.centroid.add(pix); 
         this.count.append(1);
       } 
     }
    }
    for (int k= this.colors.size()-1; k>=0; k--){
      this.centroid.set(k, this.centroid.get(k).mult(this.centroid.get(k).mag()/this.count.get(k)));
      print(k);
    }
  print(b);
  //print(this.centroid);
  print(this.count);
  //print(colors_arr.length);
  //print(a);
  print(colors.get(0).c);
  }
  
  
  
}  
