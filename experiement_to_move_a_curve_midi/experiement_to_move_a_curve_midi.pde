float aX, aY, bX, bY, cX, cY, dX, dY, 
      changingFactor, distanceMouseVector, smallerDistance; 
int counter, vectorIndex, area, maxStackArea; 

//Black color in processing. 
int BLACK = -13421773; 

PVector closestVector;
PShape s;

boolean mouseDragged = false; 
boolean changeSound = false; 

float pixelToSound; 

float baseFrequency; 

String[] noteScale = {"C","C#","D","D#","E","F","F#","G","G#", "A","A#","B"};
String[] noteScaleInversed = {"B", "A#","A","G#","G","F#","F","E","D#","D","C#","C"};
String noteUsed; 



void setup(){
  size(600, 400, P2D); 
  
  // each stack has value that depends on their size
  // there is a fixed max value of the area of the stack that have consequences
  // eg the 1st stack size changes the frequency of the base line 
  // but the size taken in account is between 1 and 1/4 of the area. 
  // If the stack is bigger, wont change the frequency 
  area = width * height; 
  maxStackArea = area / 4; 
  
  //This multiply the effects of the mouse on the shape
  changingFactor = 1; 
  
  //setup the shape 1
  randomCircle();  
  
  //initialize the minim for the sound 
  minim = new Minim(this);
  
  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();
  
  //create the base of the sound that is always active
  out.playNote( 0, 2.9, new SineInstrument( baseFrequency ) );

}

void draw(){

  background(51);
  stroke(255);
  strokeWeight(3); 
  
  //draw the shape
  shape(s); 
  
  //map the area of grey pixel to the frequency to be played
  float freq = mapAreaToNote(noteScaleInversed, "4");
  
  //change the shape in link with mouse movements
  if(mouseDragged == true){
    changeShape(); 
    pixelToSound();
  }
  
  //if the mouse has been dragged and release, call the new sound
  if(changeSound == true){
    out.playNote( 0, 2.9, new SineInstrument( freq ) );
    changeSound = false; 
  }
}

void mouseClicked(){
  //do nothing
}

void mouseReleased(){
  if(mouseDragged == true){
    changeSound = true; 
    mouseDragged = false; 
  }
}

void mouseDragged(){
  mouseDragged = true; 
}
