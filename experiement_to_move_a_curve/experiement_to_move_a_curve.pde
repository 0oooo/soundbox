int aX, aY, bX, bY, ctrlaX, ctrlaY, ctrlbX, ctrlbY, changingFactor, distanceMousePoint, distancePointMouse; 
float distFromA, distFromB; 
boolean lockedPoint; 

void setup(){
  size(600, 400); 
  
  //create shape
  aX = ctrlaX = 100; 
  aY = ctrlaY = bY = ctrlbY = 170;
  bX = ctrlbX = 400; 
  changingFactor = 10; 
}

void draw(){
  
  stroke(255); 
  noFill();
  background(0); 
  
  strokeWeight(7); 
  drawPoints();
 
  beginShape(); 
  strokeWeight(1);
  drawVertex(); 
  endShape(); 
}

void mouseDragged(){
  if(approxClickPoint() > 0){
    changePoint(approxClickPoint());   
  }else{
    if(lockedPoint == false){
      changeCurve(); 
    }
  }
}

void mouseReleased(){
  lockedPoint = false; 
}
