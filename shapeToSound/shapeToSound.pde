import processing.sound.*; //<>// //<>// //<>//

float aX, aY, bX, bY, cX, cY, dX, dY, 
  changingFactor, distanceMouseVector, smallerDistance; 
int counter, vectorIndex, area, maxStackArea, 
  numberOfClick; 

int interval = 3000, 
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

boolean similarClusters = false; 


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
  if (numberOfClick == 4) {
    shape(s1);
    shape(s2);
    shape(s3);
    shape(s4);
  }
  if (numberOfClick == 5) {
    shape(s2);
    shape(s3);
    shape(s4);
  }
  if (numberOfClick == 6) {
    shape(s3);
    shape(s4);
  }
  if (numberOfClick == 7) {
    shape(s4);
  }
  if (numberOfClick == 8) {
  }
  if (numberOfClick == 9) {
    shape(s1);
    shape(s3);
    shape(s4);
  }
  if (numberOfClick == 10) {
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

  //check the clusters every 2000 ms 
  if (millis() > trigger) {
    //get a new "picture" of the clusters
    newClusters = clusterFactory.identifyClusters();
    println("-------------------------- NEW PICTURE ---------------------------------------");

    //To differenciate the existing clusters and new ones, need 2 array lists to keep track of
    HashMap<Integer, Cluster> identified = new HashMap<Integer, Cluster>();  
    ArrayList<Cluster> unidentified = new ArrayList<Cluster>();

    if (newClusters.getSize() == 0) {
      println("No new clusters, the old ones are set to null");
      currentClusters = null;
    
    } else  {
        println("~ At least one cluster has been identified in new picture ~");
        //first time we go through: 
        if (currentClusters == null ) {
          println("~~ First time we go through, new is copied in current ~~");
          currentClusters = newClusters;   //type: ClusterCollection 

          //all the other times, compare the clusters of the current "picture" with the old picture to update them
        } else {      

          ArrayList<Cluster> newListClusters = newClusters.getClusterCollection();
          ArrayList<Cluster> currListClusters = currentClusters.getClusterCollection();
          println("The new list is made of " + newListClusters.size() );
          println("The old list is made of " + currListClusters.size() );

          //for each new cluster in the new picture
          println("\n**** Cluster Comparison / Identification ****\n");
          for (Cluster newCluster : newListClusters) {

            //compare to each of the old (current) ones
            for (Cluster currCluster : currListClusters) {


              // if the ID of the current cluster is already in the list of identified existing clusters
              // break to compare the current cluster with another one in the list of new ones
              // for ex if I already have C1 identified, and I start looking at (new) C2, I don't lose time
              // comparing C2 with C1 that has already been compared and find similar to a new C1
              int currId = currCluster.getId();
              if (identified.get(currId) != null) {
                println("The id of the old picture cluster is already in identified"); 

                //TODO check if this is not a pb with different sizes
                if ( currListClusters.size() == identified.size()) {
                  println("But it was the last element of the old cluster list to compare to so we add the new one to unindetified");
                  unidentified.add(newCluster);
                  break;
                } else {
                  continue;
                }

                // else I start comparing each pixel (that are keys of hashmap in that context) of new and curr clusters
                // as soon as one pixel is in common, its means the id of the cluster is the same, and cluster can be updated
              } else {
                boolean foundSimilarPixel = newCluster.compareCluster(currCluster); 
                similarClusters = foundSimilarPixel;
                if (foundSimilarPixel) {
                  println("Found pixels in common for 2 clusters. \nOld cluster number: " + currCluster.getId() + " and new cluster number:" +  newCluster.getId());
                  println("Proof\nKey old: " + currCluster.getKeyTest() + "\nNew key: " + newCluster.getKeyTest() ); 
                  //get the ID from the current (old) cluster, set it to the new one, and put them in the identified list
                  int newId = currCluster.getId(); 
                  newCluster.setId(newId); 
                  identified.put(newId, newCluster);
                  break;
                }
              }
            }//end of current cluster list

            //if newCluster has compared all the old ones and didn't find a similarity, add to the unidentified list
            if (!similarClusters) {
              println("New cluster number: " + newCluster.getId() + " has no similarity with old ones. Added to unidentified.");
              println("\nNew key: " + newCluster.getKeyTest() ); 
              unidentified.add(newCluster);
            }
          }//end of new cluster list
          println("\n**** End of Cluster Comparison / Identification ****\n");
        }//end of comparing 2 clusters' pixels

        //if the unidentified is not empty, needs to reassign an id to them
        println("1. (should be numbers of new cluster) Unidentified : " + unidentified.size());
        println("2. (should be numbers of similar cluster) Identified : " + identified.size());
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

        println("3. (should be total number of cluster) Identified : " + identified.size());
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
