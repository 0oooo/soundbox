
boolean goUp(){
  if(mouseY < pmouseY){
    return true; 
  }else{
    return false; 
  }
}

boolean goDown(){
  if(mouseY > pmouseY){
    return true; 
  }else{
    return false; 
  }
}

boolean goLeft(){
  if(mouseX < pmouseX){
    return true; 
  }else{
    return false; 
  }
}

boolean goRight(){
  if(mouseX > pmouseX){
    return true; 
  }else{
    return false; 
  }
}

int getSide(){
  
  distFromA = dist(aX, aY, mouseX, mouseY); 
  distFromB = dist(bX, bY, mouseX, mouseY); 
  
  if(distFromA < distFromB){ 
    return 1; 
  }else if(distFromA > distFromB){
    return 2; 
  }else if(distFromA == distFromB){
    return 3; 
    //ignore until next frame (when the mouse goes in one or the other camps)
  }else {
    return 0; 
  }
}

// while the mouse is located, 1 means the left side of the vertex should move
//2 means the right side of the vertex should move, 3 is for both
void changeCurve(){
  
  if(getSide() > 0){
    //close to first point a, controls aX and aY need to change coordinates
    if(getSide() == 1){
      
      if(goUp() && goLeft()){
        //idea: maybe do the opposite aka if mouse - mouse p => ctrlaX + the difference
        ctrlaX = (ctrlaX + (pmouseX - mouseX) * changingFactor);  
        ctrlaY = (ctrlaY + (pmouseY - mouseY) * changingFactor);  
      }else if(goUp() && goRight()){
        ctrlaX = (ctrlaX - (mouseX - pmouseX) * changingFactor); 
        ctrlaY = (ctrlaY + (pmouseY - mouseY) * changingFactor); 
      }else if(goDown() && goLeft()){
        ctrlaX = (ctrlaX + (pmouseX - mouseX) * changingFactor); 
        ctrlaY = (ctrlaY - (mouseY - pmouseY) * changingFactor); 
      }else if (goDown() && goRight()){
        ctrlaX = (ctrlaX - (mouseX - pmouseX) * changingFactor);
        ctrlaY = (ctrlaY - (mouseY - pmouseY) * changingFactor); 
      }else if (goUp()){
         ctrlaY = (ctrlaY + (pmouseY - mouseY) * changingFactor);
      }else if (goDown()){
         ctrlaY = (ctrlaY - (mouseY - pmouseY) * changingFactor);
      }else if (goLeft()){
        ctrlaX = (ctrlaX + (pmouseX - mouseX) * changingFactor);
      }else if (goRight()){
        ctrlaX = (ctrlaX - (mouseX - pmouseX) * changingFactor); 
      }
      
    
      //close to the second point b, controls bX and bY need to change coordinates
    }else if (getSide() == 2){
      if(goUp() && goLeft()){
        ctrlbX = (ctrlbX + (pmouseX - mouseX) * changingFactor);  
        ctrlbY = (ctrlbY + (pmouseY - mouseY) * changingFactor);  
      }else if(goUp() && goRight()){
        ctrlbX = (ctrlbX + (pmouseX - mouseX) * changingFactor);  
        ctrlbY = (ctrlbY + (pmouseY - mouseY) * changingFactor);  
      }else if(goDown() && goLeft()){
        ctrlbX = (ctrlbX + (pmouseX - mouseX) * changingFactor);  
        ctrlbY = (ctrlbY + (pmouseY - mouseY) * changingFactor);  
      }else if (goDown() && goRight()){
        ctrlbX = (ctrlbX + (pmouseX - mouseX) * changingFactor);  
        ctrlbY = (ctrlbY + (pmouseY - mouseY) * changingFactor);  
      }else if (goUp()){
        ctrlbY = (ctrlbY + (pmouseY - mouseY) * changingFactor);
      }else if (goDown()){
        ctrlbY = (ctrlbY - (mouseY - pmouseY) * changingFactor);
      }else if (goLeft()){
        ctrlbX = (ctrlbX + (pmouseX - mouseX) * changingFactor);
      }else if (goRight()){
        ctrlbX = (ctrlbX - (mouseX - pmouseX) * changingFactor); 
      }
    
      //equidistance from both points, both controls need to change coordinates    
    }else if(getSide() == 3){ 
      if(goUp() && goLeft()){
        ctrlaX = (ctrlaX + (pmouseX - mouseX) * changingFactor);  
        ctrlaY = (ctrlaY + (pmouseY - mouseY) * changingFactor);
        ctrlbX = (ctrlbX + (pmouseX - mouseX) * changingFactor);  
        ctrlbY = (ctrlbY + (pmouseY - mouseY) * changingFactor);
        println("You are equidistance going up and left");
      }else if(goUp() && goRight()){
        ctrlaX = (ctrlaX - (mouseX - pmouseX) * changingFactor); 
        ctrlaY = (ctrlaY + (pmouseY - mouseY) * changingFactor);
        ctrlbX = (ctrlbX + (pmouseX - mouseX) * changingFactor);  
        ctrlbY = (ctrlbY + (pmouseY - mouseY) * changingFactor);
        println("You are equidistance going up and right");
      }else if(goDown() && goLeft()){
        ctrlaX = (ctrlaX + (pmouseX - mouseX) * changingFactor); 
        ctrlaY = (ctrlaY - (mouseY - pmouseY) * changingFactor);
        ctrlbX = (ctrlbX + (pmouseX - mouseX) * changingFactor);  
        ctrlbY = (ctrlbY + (pmouseY - mouseY) * changingFactor);
        println("You are equidistance going down and left");
      }else if (goDown() && goRight()){
        ctrlaX = (ctrlaX - (mouseX - pmouseX) * changingFactor);
        ctrlaY = (ctrlaY - (mouseY - pmouseY) * changingFactor);
        ctrlbX = (ctrlbX + (pmouseX - mouseX) * changingFactor);  
        ctrlbY = (ctrlbY + (pmouseY - mouseY) * changingFactor);
        println("You are equidistance going down and right");
      }else if (goUp()){
        ctrlaY = (ctrlaY + (pmouseY - mouseY) * changingFactor);
        ctrlbY = (ctrlbY + (pmouseY - mouseY) * changingFactor);
      }else if (goDown()){
        ctrlaY = (ctrlaY - (mouseY - pmouseY) * changingFactor);
        ctrlbY = (ctrlbY - (mouseY - pmouseY) * changingFactor);
      }else if (goLeft()){
        ctrlaX = (ctrlaX + (pmouseX - mouseX) * changingFactor);
        ctrlbX = (ctrlbX + (pmouseX - mouseX) * changingFactor);
      }else if (goRight()){
        ctrlaX = (ctrlaX - (mouseX - pmouseX) * changingFactor); 
        ctrlbX = (ctrlbX - (mouseX - pmouseX) * changingFactor);
      }
 
    }else{
      println("This was an else situation...");
    }
  }
}

void changePoint(int side){
  if(side == 1){
    aX = mouseX; 
    aY = mouseY; 
  }if(side == 2){
    bX = mouseX; 
    bY = mouseY; 
  }
  lockedPoint = true; 
}
