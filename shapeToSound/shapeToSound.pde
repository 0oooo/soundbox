float aX, aY, bX, bY, cX, cY, dX, dY, 
      changingFactor, distanceMouseVector, smallerDistance; 
int counter, vectorIndex, area, maxStackArea, 
    numberOfClick; 

//Black color in processing. 
int BLACK = -13421773; 

PVector closestVector;
PShape s, s1, s2, s3, s4;

boolean mouseDragged = false; 
boolean changeSound = false;
boolean mouseClicked = false; 

float pixelToSound; 

float baseFrequency; 

String[] noteScale = {"C","C#","D","D#","E","F","F#","G","G#", "A","A#","B"};
String[] noteScaleInversed = {"B", "A#","A","G#","G","F#","F","E","D#","D","C#","C"};
String noteUsed; 

PImage img;

ClusterFactory clusterFactory;
ClusterCollection clusterCollection; 


void setup(){
  
  size(600, 400, P2D); 
  
  // attribute a max area to each clusters depending on how many clusters are present 
  area = width * height; 
                      // change for numbers of clusters
  maxStackArea = area / 4; 
  
  //This multiply the effects of the mouse on the shape
  changingFactor = 1; 
  
  //create the clusters factory
  clusterFactory = new ClusterFactory(width, height);
  
  // Link the number of clicks to the creation of the shapes
  numberOfClick = 0;
  
  //setup the shape 1
  s1 = randomCircle(width/2, height/2, 0, 0, s1);
  s2 = randomCircle(width/2, height/2, width/2, 0, s2);
  s3 = randomCircle(width/2, height/2, 0, height/2, s3);
  s4 = randomCircle(width/2, height/2, width/2, height/2, s4);
  
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
  if(numberOfClick == 1){
  shape(s1);
  }
  if(numberOfClick == 2){
  shape(s1);
  shape(s2);
  }
  if(numberOfClick == 3){
  shape(s1);
  shape(s2);
  shape(s3); 
  }
  if(numberOfClick >= 4){
  shape(s1);
  shape(s2);
  shape(s3);
  shape(s4);
  }
  
  //map the area of grey pixel to the frequency to be played
  float freq = mapAreaToNote(noteScaleInversed, "4");
  
  //change the shape in link with mouse movements
  if(mouseDragged == true){
    if(mouseLeftTop()){
      changeShape(s1);
      pixelToSound();
    }
    if(mouseRightTop()){
      changeShape(s2);
    }
    if(mouseLeftBottom()){
      changeShape(s3);
    }
    if(mouseRightBottom()){
      changeShape(s4);
    }
  }
  
  //detect the clusters of pixel everytime the mouse is clicked
  if(mouseClicked == true){
    clusterCollection = clusterFactory.identifyClusters();
    clusterFactory.displayClusters();
    mouseClicked = false; 
  }
  
  //if the mouse has been dragged and release, call the new sound
  if(changeSound == true){
    out.playNote( 0, 2.9, new SineInstrument( freq ) );
    changeSound = false; 
  }
}

void mouseClicked(){
  numberOfClick++;
  mouseClicked = true; 
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
