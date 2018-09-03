float aX, aY, bX, bY, cX, cY, dX, dY, 
      changingFactor, distanceMouseVector, smallerDistance; 
int counter, vectorIndex; 

PVector closestVector;
PShape s;


void setup(){
  size(600, 400, P2D); 
  noLoop(); 
  
  //This multiply the effects of the mouse on the shape
  changingFactor = 1; 
  
  //setup the shape 1
  randomCircle();  
  
  // Create triangle wave and envelope for MIDI 
  triOsc = new TriOsc(this);
  env  = new Env(this);
}

void draw(){

  background(51);
  stroke(255);
  strokeWeight(3); 
  
  //draw the shape
  shape(s); 
  
  //get the number of grey pixel aka the surface of the grey area. 
  pixelCount();
}

void mouseClicked(){

}

void mouseDragged(){
  //change the shape in link with mouse movements and redraw it
    changeShape(); 
    redraw();
}
