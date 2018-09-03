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


int getCloseVertex(){ 
  
  smallerDistance = distanceMouseVector; 
  for(int x = 0; x < s.getVertexCount(); x++){
    PVector v = s.getVertex(x);  
    distanceMouseVector = dist(v.x, v.y, mouseX, mouseY);
    if(distanceMouseVector < smallerDistance){
      smallerDistance = distanceMouseVector;
      closestVector = v; 
      vectorIndex = x; 
    }
  }   
  return vectorIndex; 
}

void changeShape()
{
  int index = getCloseVertex();
  PVector v =  s.getVertex(index);

  if(goUp() && goLeft()){
    v.x -= (pmouseX - mouseX) * changingFactor;
    v.y -= (pmouseY - mouseY) * changingFactor;
    s.setVertex(index, v.x, v.y);
  }else if(goUp() && goRight()){
    v.x += (mouseX - pmouseX) * changingFactor; 
    v.y -= (pmouseY - mouseY) * changingFactor;
    s.setVertex(index, v.x, v.y);
  }else if(goDown() && goLeft()){
    v.x -= (pmouseX - mouseX) * changingFactor; 
    v.y += (mouseY - pmouseY) * changingFactor;
    s.setVertex(index, v.x, v.y);
  }else if (goDown() && goRight()){
    v.x += (mouseX - pmouseX) * changingFactor;
    v.y += (mouseY - pmouseY) * changingFactor; 
    s.setVertex(index, v.x, v.y);
  }else if (goUp()){
    v.y -= (pmouseY - mouseY) * changingFactor;
    s.setVertex(index, v.x, v.y);
  }else if (goDown()){
    v.y += (mouseY - pmouseY) * changingFactor;
    s.setVertex(index, v.x, v.y);
  }else if (goLeft()){ 
    v.x -= (pmouseX - mouseX) * changingFactor;
    s.setVertex(index, v.x, v.y);
  }else if (goRight()){
    v.x += (mouseX - pmouseX) * changingFactor;
    s.setVertex(index, v.x, v.y);
  } 
}


//no used now but could be later. 
void getCircumferance(){
   float[] vectorSizes = new float[s.getVertexCount()];
   float pastX = s.getVertex(0).x; 
   float pastY = s.getVertex(0).y; 
   float surface = 0;
   
   for(int i = 1; i < s.getVertexCount(); i++){
    PVector v = s.getVertex(i);  
  //  println(i, ": ", v); 

    float d = dist(pastX, pastY, s.getVertex(i).x, s.getVertex(0).y);
    surface += d; 
    pastX = s.getVertex(i).x; 
    pastY = s.getVertex(i).y;    
   }
   println(surface); 
}
