float aX, aY, bX, bY, cX, cY, dX, dY, 
      changingFactor, distanceMouseVector, smallerDistance; 
int counter, vectorIndex; 

PVector closestVector;
PShape s;


void setup(){
  size(600, 400, P2D); 

  noLoop(); 
  changingFactor = 1; 
  randomCircle();   
}

void draw(){

  background(51);
  stroke(255);
  strokeWeight(3); 
  
  //draw the shape
  shape(s); 
  
}


void mouseDragged(){
    changeShape(); 
    redraw();
}
