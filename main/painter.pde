
class Painter{
  String[] imgNames = {cover_path};
  int imgIndex = 0;
  PImage img =  Img;//loadImage(imgNames[imgIndex]);
  PImage controlImg =  imgObject.img_obj;//loadImage(segmentation_path);
  
  Painter(){
    this.img.loadPixels();
    this.controlImg.loadPixels();
  }
  void paintStroke(float strokeLength, color strokeColor, int strokeThickness) {
    float stepLength = strokeLength/4.0;
    
    // Determines if the stroke is curved. A straight line is 0.
    float tangent1 = 0;
    float tangent2 = 0;
    
    float odds = random(1.0);
    
    if (odds < 0.7) {
      tangent1 = random(-strokeLength, strokeLength);
      tangent2 = random(-strokeLength, strokeLength);
    } 
    
    // Draw a big stroke
    noFill();
    stroke(strokeColor);
    strokeWeight(strokeThickness);
    curve(tangent1, -stepLength*2, 0, -stepLength, 0, stepLength, tangent2, stepLength*2);
    
    int z = 1;
    
    // Draw stroke's details
    for (int num = strokeThickness; num > 0; num --) {
      float offset = 0;/*random(0,0.2)0.3*audioManager.getSpecRoll();*/
      color newColor = color(hue(strokeColor)/**audioManager.getSpecCent()+offset*/, saturation(strokeColor)+offset, brightness(strokeColor)+offset);
      //color newColor = color(hue(strokeColor)+offset, saturation(strokeColor)+offset,  beat_coloration()*brightness(strokeColor)+offset);
      
      stroke(newColor);
      strokeWeight((int)random(0, 3));
      curve(tangent1, -stepLength*2, z-strokeThickness/2, -stepLength*random(0.9, 1.1), z-strokeThickness/2, stepLength*random(0.9, 1.1), tangent2, stepLength*2);
 
      z += 1;
    }
  }
  
  
  void painting(color col) {
    resetMatrix();
    translate(width/2, height/2);
    
    int index = 0;
    
    for (int y = 0; y < size; y+=1) {
      for (int x = 0; x < size; x+=1) {
        int odds = (int)random(10000);
        
        if (odds < 1) {
          color pixelColor = img.pixels[index];
          color controlColor = controlImg.pixels[index];
          pixelColor = color(hue(pixelColor), saturation(pixelColor), brightness(pixelColor));
          //pixelColor = color(hue(pixelColor), saturation(pixelColor), beat_coloration()*brightness(pixelColor));
          if (controlColor == col){
          pushMatrix();
          translate(x-size/2, y-size/2);
          rotate(radians(random(-90, 90)));
          
          // Paint by layers from rough strokes to finer details
            // Small strokes
            for (int i =0;i<3;i++){
              paintStroke(random(30, 60), pixelColor, (int)random(1, 4));
            }
          
          popMatrix();
          }          
        }
        
        index += 1;
      }
    }
    //if (frameCount > 600) {
    //  noLoop();
    //}}}}}}}}}   //  nk*oLoop();
    //}
  }
}
