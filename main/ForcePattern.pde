class ForcePattern {
  
  ForcePatternType type;
  
  ForcePattern(){
    type = ForcePatternType.CIRCLE_LEFT;
  }
  
  PVector getForce(PVector pos, PVector vel, PVector origin){
    PVector force = new PVector();
    
    if(this.type == ForcePatternType.RADIAL_EXT){
      force.x = 1;
      force.y = 1;
    }else if(this.type == ForcePatternType.CIRCLE_LEFT || this.type == ForcePatternType.CIRCLE_RIGHT){
      
      float angleRot = 0.2*random(0.9, 1.1);
      
      if(this.type == ForcePatternType.CIRCLE_LEFT){
        angleRot = -angleRot;
      }
      PVector posOrigin = PVector.sub(pos, origin);
      posOrigin.rotate(angleRot);
      
      PVector expectedPos = PVector.add(origin, posOrigin);
      PVector realPos = pos.add(vel);
      
      force = expectedPos.sub(realPos);
      force.x = force.x*random(0.9, 1.1);
      force.y = force.y*random(0.9, 1.1);
    }
    
    return force;
  }
}
