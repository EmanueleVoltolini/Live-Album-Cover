class ForcePattern {
  
  ForcePatternType type;
  
  ForcePattern(){
    type = ForcePatternType.RADIAL_INT;
  }
  
  PVector getForce(PVector pos, PVector vel, PVector origin){
    PVector force = new PVector();
    
    if(this.type == ForcePatternType.RADIAL_EXT){
      force.x = 2*audioManager.getRMS();
      force.y = 2*audioManager.getRMS();
    }
    else if(this.type == ForcePatternType.RADIAL_INT){
      force.x = -2*audioManager.getRMS();
      force.y = 2*audioManager.getRMS();
    }
    else if(this.type == ForcePatternType.ATTRACT){
      force.x = 1;
      force.y = 1;
      PVector posOrigin = PVector.sub(pos, origin);
      PVector expectedPos = PVector.add(origin, posOrigin);
      PVector realPos = pos.add(vel);
      //if(expectedPos.x<0||expectedPos.y<0){print(expectedPos);}
      //if(pos.x<0||pos.y<0){printos);}
      force = expectedPos.sub(realPos);
      force =force.mult(9);
    }    
    else if(this.type == ForcePatternType.CIRCLE_LEFT || this.type == ForcePatternType.CIRCLE_RIGHT){
      
      
      float angleRot = 0.5 + pow(audioManager.getRMS(), 4);
      
      if(this.type == ForcePatternType.CIRCLE_LEFT){
        angleRot = -angleRot;
      }
      PVector posOrigin = PVector.sub(pos, origin);
      posOrigin.rotate(angleRot);
      //posOrigin.mult(0.95);
      posOrigin.mult(2*audioManager.getRMS());
      
      PVector expectedPos = PVector.add(origin, posOrigin);
      PVector realPos = pos.add(vel);
      //if(expectedPos.x<0||expectedPos.y<0){print(expectedPos);}
      //if(pos.x<0||pos.y<0){printos);}
      force = expectedPos.sub(realPos);
    }
    //print(force);
    return force;
  }
  
  void changePattern(){
    if(this.type == ForcePatternType.CIRCLE_LEFT){
      this.type = ForcePatternType.CIRCLE_RIGHT;
    }else if(this.type == ForcePatternType.CIRCLE_RIGHT){
      this.type = ForcePatternType.CIRCLE_LEFT;
    }
  }
}
