class ImgManager {
  PImage img_cover;
  float prevBeat;
  
  ImgManager(){
    img_cover = loadImage("cover.jpg");
    prevBeat = 0;
  }
  
  color getCoverPxColor(PVector pos){
   return img_cover.get(int(pos.x/size*img_cover.width), int(pos.y/size*img_cover.height));
  }
  
  void drawCover(){
    
    //image colors modifications
    
    image(img_cover, size/2, size/2, size, size);
    
    float timeDiff = audioManager.getTimeFromLastBeat();
    
    float k = 1;
    float brightness = max(0.8-k*pow(timeDiff, 0.6), 0.5);
    
    tint(0, 0, brightness);
  }
  
}
