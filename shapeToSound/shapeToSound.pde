float aX, aY, bX, bY, cX, cY, dX, dY, 
  changingFactor, distanceMouseVector, smallerDistance; 
int counter, vectorIndex, area, maxStackArea, 
  numberOfClick; 

int interval = 1000, 
  trigger = 0; 

//Black color in processing. 
int BLACK = -13421773; 

PVector closestVector;
PShape s, s1, s2, s3, s4;

boolean mouseDragged = false; 
boolean changeSound = false;
boolean mouseClicked = false; 

float pixelToSound; 

float baseFrequency; 

String[] noteScale = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"};
String[] noteScaleInversed = {"B", "A#", "A", "G#", "G", "F#", "F", "E", "D#", "D", "C#", "C"};
String noteUsed; 

PImage img;

ClusterFactory clusterFactory;
ClusterCollection currentClusters, newClusters; 


void setup() {

  size(600, 400, P2D); 

  // attribute a max area to each clusters depending on how many clusters are present 
  area = width * height; 
  // change for numbers of clusters
  maxStackArea = area / 4; 

  //This multiply the effects of the mouse on the shape
  changingFactor = 1; 

  //create the clusters factory
  clusterFactory = new ClusterFactory(width, height);
  currentClusters = null; 

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

void draw() {

  background(51);

  stroke(255);
  strokeWeight(3); 

  //draw the shape
  if (numberOfClick == 1) {
    shape(s1);
  }
  if (numberOfClick == 2) {
    shape(s1);
    shape(s2);
  }
  if (numberOfClick == 3) {
    shape(s1);
    shape(s2);
    shape(s3);
  }
  if (numberOfClick >= 4) {
    shape(s1);
    shape(s2);
    shape(s3);
    shape(s4);
  }



  //change the shape in link with mouse movements
  if (mouseDragged == true) {
    if (mouseLeftTop()) {
      changeShape(s1);
      pixelToSound();
    }
    if (mouseRightTop()) {
      changeShape(s2);
    }
    if (mouseLeftBottom()) {
      changeShape(s3);
    }
    if (mouseRightBottom()) {
      changeShape(s4);
    }
  }

  //check the clusters every 500 ms 
  if (millis() > trigger) {
    //get a new "picture" of the clusters
    newClusters = clusterFactory.identifyClusters();

    //To differenciate the existing clusters and new ones, need 2 array lists to keep track of
    //ArrayList<Cluster> identified, unidentified; 
    HashMap<Integer, Cluster> identified = new HashMap<Integer, Cluster>();  
    //HashMap<Integer, Cluster> unidentified = new HashMap<Integer, Cluster>();; 
    ArrayList<Cluster> unidentified = new ArrayList<Cluster>();

    if (newClusters.getSize() > 0) {
      //first time we go through: 
      if (currentClusters == null ) {
        currentClusters = newClusters;   //type: ClusterCollection 

        //all the other times, compare the clusters of the current "picture" with the old picture to update them
      } else {      

        ArrayList<Cluster> newListClusters = newClusters.getClusterCollection();
        ArrayList<Cluster> currListClusters = currentClusters.getClusterCollection();
        println("The new list is made of " + newListClusters.size() );
        println("The old list is made of " + currListClusters.size() );

        //for each new cluster in the new picture
        for (Cluster newCluster : newListClusters) {

          //compare to each of the old (current) ones
          for (Cluster currCluster : currListClusters) {

            // if the ID of the current cluster is already in the list of identified existing clusters
            // break to compare the current cluster with another one in the list of new ones
            // for ex if I already have C1 identified, and I start looking at (new) C2, I don't lose time
            // comparing C2 with C1 that has already been compared and find similar to a new C1
            int currId = currCluster.getId();
            if (identified.get(currId) != null) {
              break; 

              // else I start comparing each pixel (that are keys of hashmap in that context) of new and curr clusters
              // as soon as one pixel is in common, its means the id of the cluster is the same, and cluster can be updated
            } else {
              boolean foundSimilarPixel = newCluster.compareCluster(currCluster); 

              if (foundSimilarPixel) {
                //get the ID from the current (old) cluster, set it to the new one, and put them in the identified list
                int newId = currCluster.getId(); 
                newCluster.setId(newId); 
                identified.put(newId, newCluster);
                break;
              }
              //else it goes in the unidentified list
              else {
                unidentified.add(newCluster);
              }
            }
          }//end of current cluster list
        }//end of new cluster list
      }//end of comparing 2 clusters' pixels

      //if the unidentified is not empty, needs to reassign an id to them
      println("1. Unidentified : " + unidentified.size());
      if ( unidentified.size()> 0) {
        //find the smallest ID not in used in the identified list
        int min = 1; 
        for ( int i = 0; i < unidentified.size(); i ++) {
          while (identified.containsKey(min) == true) {
            min++;
          }

          //assign it to the cluster of the unidentified list
          //and push it with its new id to the identified list
          int newId = min; 
          Cluster unidentifiedCluster = unidentified.get(i);
          unidentifiedCluster.setId(newId); 
          identified.put(newId, unidentifiedCluster);
        }
        unidentified.clear(); 
      }//end of completing the identified list
      println("2. Unidentified : " + unidentified.size());

      if ( identified.size() > 0) {       // Create an arrayList of all the clusters in the identified list                                         
                                          // source https://crunchify.com/how-to-convert-hashmap-to-arraylist-in-java/
        ArrayList<Cluster> clusterList = new ArrayList<Cluster>(identified.values());
        println("Size of my new array list to copy in curr : "  + clusterList.size() );
        
        // push the final arrayList to be the new currentClusters
        currentClusters = new ClusterCollection(clusterList);
        identified.clear(); 
      }//end of copying identified list into a ClusterCollection


      //checks 
      //clusterFactory.displayClusters();
      //newClusters.displayClusterCollection();
    
    }//end of checking there is at least one cluster in the new image
    //condition was introduced as a nullpointer was appearing at the begining
    //btw pb with that is if all clu. disappear, need to be able to get it


    trigger = millis() + interval;
  }

  //if the mouse has been dragged and release, call the new sound
  if (changeSound == true) {
    //map the area of grey pixel to the frequency to be played
    float freq = mapAreaToNote(noteScaleInversed, "4");
    out.playNote( 0, 2.9, new SineInstrument( freq ) );
    changeSound = false;
  }
}

void mouseClicked() {
  numberOfClick++;
  mouseClicked = true;
}



void mouseReleased() {
  if (mouseDragged == true) {
    changeSound = true; 
    mouseDragged = false;
  }
}

void mouseDragged() {
  mouseDragged = true;
}


// This function calculates the respective frequency of a MIDI note
float midiToFreq(int note) {
    return (pow(2, ((note-69)/12.0)))*440;
}