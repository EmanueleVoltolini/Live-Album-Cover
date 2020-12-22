class ImgManager {
  PImage img_cover;
  float prevBeat;
  
  ImgManager(){
    img_cover = loadImage("cover2.jpg");
    prevBeat = 0;
  }
  
  color getCoverPxColor(PVector pos){
   return img_cover.get(int(pos.x/size*img_cover.width), int(pos.y/size*img_cover.height));
  }
  
  void drawCover(){
    
    //image colors modifications
    
    image(img_cover, size/2, size/2, size, size);
    
    float lastBeat = audioManager.getLastBeatTime();
    float currentTime = System.currentTimeMillis() - playedAt;
    float timeDiff = currentTime/1000-lastBeat;
    
    float brightness;
    float k = 1;
    if(lastBeat != prevBeat){
      brightness = 0.7;
      prevBeat = lastBeat;
    }else{
      brightness = max(0.7-k*pow(timeDiff, 0.6), 0.4);
    }
     //<>//
    tint(0, 0, brightness);
  }
  
}
