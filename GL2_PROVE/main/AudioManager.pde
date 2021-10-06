JSONObject json;
long playedAt;

JSONArray zcr;
JSONArray specdec;
JSONArray speccentr;
JSONArray rms;
JSONArray specroll;
JSONArray beats;
float hopsize;



class AudioManager {
  AudioManager(){
    
      
    json = loadJSONObject(audioFeature_path);
    zcr = json.getJSONArray("zcr");
    specdec = json.getJSONArray("specdec");
    speccentr = json.getJSONArray("speccentr");
    rms = json.getJSONArray("rms");
    specroll = json.getJSONArray("specroll");
    beats = json.getJSONArray("beats");
    hopsize = json.getFloat("hopsize_s");
    //print(hopsize);
    file.play();
    playedAt = System.currentTimeMillis();
  }
  
  
  float getZCR(){
    long currentTime = System.currentTimeMillis();
    long timeDiff = currentTime-playedAt;
    float ind = float(int(timeDiff))/1000.0 / hopsize;
    int index = round(ind);
    float val = zcr.getFloat(min(index, zcr.size()-1));
    return val;
  }
  
  float getRMS(){
    long currentTime = System.currentTimeMillis();
    long timeDiff = currentTime-playedAt;
    float ind = float(int(timeDiff))/1000.0 / hopsize;
    int index = round(ind);
    float val = rms.getFloat(min(index, rms.size()-1));
    return val;
  }
    float getSpecDec(){
    long currentTime = System.currentTimeMillis();
    long timeDiff = currentTime-playedAt;
    float ind = float(int(timeDiff))/1000.0 / hopsize;
    int index = round(ind);
    float val = specdec.getFloat(min(index, specdec.size()-1));
    return val;
  }
    float getSpecRoll(){
    long currentTime = System.currentTimeMillis();
    long timeDiff = currentTime-playedAt;
    float ind = float(int(timeDiff))/1000.0 / hopsize;
    int index = round(ind);
    float val = specroll.getFloat(min(index, specdec.size()-1));
    return val;
  }

    float getSpecCent(){
    long currentTime = System.currentTimeMillis();
    long timeDiff = currentTime-playedAt;
    float ind = float(int(timeDiff))/1000.0 / hopsize;
    int index = round(ind);
    float val = speccentr.getFloat(min(index, specdec.size()-1));
    return val;
  }  
  
  float getLastBeatTime(){
    long currentTime = System.currentTimeMillis();
    long timeDiff = currentTime-playedAt;
    
    int i = 0;
    float currBeat;
    while(true){
      currBeat = beats.getFloat(i);
      if(float(int(timeDiff))/1000 < currBeat || i >= beats.size()-1){
        break;
      }
      i++;
    }
    return beats.getFloat(max(0, i-1));
  }
  
  float getTimeFromLastBeat(){
    float lastBeat = getLastBeatTime();
    long currentTime = System.currentTimeMillis() - playedAt;
    float val = float(int(currentTime))/1000-lastBeat;
    return val; //<>//
  }
  
  float getBeat(int index){
    float b;
    float c;
    
    b=beats.getFloat(index);
    c=beats.getFloat(index+1);
    b=c-b;
    return b;
  }
  
  float beat_duration(){
    /*int i = 0;
    float currValue=0;
    while(true){
      currValue = currValue+beats.getFloat(i+1)-beats.getFloat(i);
      if(i >= beats.size()-1){
        break;
      }
      i++;
    }
    return currValue/i;*/
    int i;
    float a;
    a=0;
    for (i=0; i<=beats.size()-4; i++){
      a=a+getBeat(i);//beats.getFloat(i+1)-beats.getFloat(i);
      //print(a/i);
    }
    return a/i;
    //return beats.getFloat(100)-beats.getFloat(99);
  }
  
}
