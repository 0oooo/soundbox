int aX, aY, bX, bY, ctrlaX, ctrlaY, ctrlbX, ctrlbY, changingFactor; 
float distFromA, distFromB; 

void setup(){
  size(600, 400); 
  aX = ctrlaX = 100; 
  aY = ctrlaY = bY = ctrlbY = 170;
  bX = ctrlbX = 400; 

  
  changingFactor = 2; 
}

void draw(){
  
  stroke(255); 
  noFill();
  background(0); 
  strokeWeight(4); 
 
  
  point(ctrlaX, ctrlaY); 
  point(aX, aY);
  point(bX, bY);
  point(ctrlbX, ctrlbY);
 
  beginShape(); 
  strokeWeight(1);
  
  
  if(mousePressed){
        
    distFromA = dist(aX, aY, mouseX, mouseY); 
    distFromB = dist(bX, bY, mouseX, mouseY); 
    if(distFromA < distFromB){
      ctrlaX = mouseX * changingFactor; 
      ctrlaY = mouseY * changingFactor; 
    }else if(distFromA > distFromB){
      ctrlbX = mouseX * changingFactor; 
      ctrlbY = mouseY * changingFactor;
    }else if(distFromA == distFromB){
      ctrlaX = ctrlbX = mouseX * changingFactor; 
      ctrlaY = ctrlbY = mouseY * changingFactor;
    }
    
  }
  
  curveVertex(ctrlaX, ctrlaY);
  curveVertex(aX, aY);
  curveVertex(bX, bY);
  curveVertex(ctrlbX, ctrlbY);
  endShape(); 
}
