class ImgManager {
  PImage img_cover;
  
  ImgManager(){
    img_cover = loadImage("cover2.jpg");
  }
  
  color getCoverPxColor(PVector pos){
   return img_cover.get(int(pos.x/size*img_cover.width), int(pos.y/size*img_cover.height));
  }
  
  void drawCover(){
    
    //image colors modifications
    
    image(img_cover, size/2, size/2, size, size);
    
    long currentTime = System.currentTimeMillis();
      long timeDiff = currentTime-playedAt;
      float ind = float(int(timeDiff))/1000.0 / hopsize;
      
      int index = round(ind);
      float rms2 = rms.getFloat(index); //<>//
      
      tint(0, 0, rms2);
  }
  
}
