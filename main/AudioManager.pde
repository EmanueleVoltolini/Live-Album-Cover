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
    
      
    json = loadJSONObject("/../data.json");
    zcr = json.getJSONArray("zcr");
    specdec = json.getJSONArray("specdec");
    speccentr = json.getJSONArray("speccentr");
    rms = json.getJSONArray("rms");
    specroll = json.getJSONArray("specroll");
    beats = json.getJSONArray("beats");
    hopsize = json.getFloat("hopsize_s");
    
    file.play();
    playedAt = System.currentTimeMillis();
  }
  
  
  float getZCR(){
    long currentTime = System.currentTimeMillis();
    long timeDiff = currentTime-playedAt;
    float ind = float(int(timeDiff))/1000.0 / hopsize;
    int index = round(ind);
    float val = zcr.getFloat(index);
    return val;
  }
  
  float getRMS(){
    long currentTime = System.currentTimeMillis();
    long timeDiff = currentTime-playedAt;
    float ind = float(int(timeDiff))/1000.0 / hopsize;
    int index = round(ind);
    float val = rms.getFloat(index);
    return val;
  }
  
  float getLastBeatTime(){
    long currentTime = System.currentTimeMillis();
    long timeDiff = currentTime-playedAt;
    
    int i = 0;
    float currBeat;
    while(true){
      currBeat = beats.getFloat(i);
      if(timeDiff/1000 < currBeat){
        break;
      }
      i++;
    }
    return currBeat;
  }
  
}
