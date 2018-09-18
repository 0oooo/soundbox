boolean isBackground(color col) {
  float red = red(col);
  float green = green(col);
  float blue = blue(col); 
  if ((red < 53 && red > 49) && (green < 53 && green > 49) && (blue < 53 && blue > 49)) {
    return true;
  } else {
    return false;
  }
}


class Cluster {
  int highestLevel, h, w, id; 
  HashMap<String, Integer> pixelElements = new HashMap<String, Integer>(); 
  String keyTest; 

  Cluster(int h, int w, int id) {
    this.h = h; 
    this.w = w; 
    this.id = id;
  }

  void addPixel(int x, int y, int level) {
    String coordinates = str(x) + ":" + str(y); 
    pixelElements.put(coordinates, level);
  }
  
  void setKeyTest(int x, int y){
    String coordinates = str(x) + ":" + str(y); 
    keyTest = coordinates; 
  }

  boolean hasPixel(int x, int y) {
    if (x < 0 || x > (this.w - 1)) {
      return false;
    }
    if (y < 0 || y > (this.h - 1)) {
      return false;
    }
    String coordinates = str(x) + ":" + str(y); 
    if (pixelElements.get(coordinates) != null) {
      return true;
    } else {
      return false;
    }
  }
  
  boolean compareCluster(Cluster cluster2){
    //for each pixel in the current hashmap 
    //check if it;s in the second hashmap
    HashMap<String, Integer> pixel2 = cluster2.getPixels();
    for(HashMap.Entry me : pixelElements.entrySet()){
      // /!\ Originally put String but didnt work. May be an issue later
      Object pixel1 = me.getKey();  
      if (pixel2.containsKey(pixel1)){
        return true; 
      }
    }
    return false; 
  }           
  
   HashMap<String, Integer> getPixels(){
     return pixelElements;
   }
   
   String getKeyTest(){
     return keyTest; 
   }

  int getSize() {
    return pixelElements.size();
  }
  
  void setId(int id){
    this.id = id; 
  }
  
  public int getId(){
    return id; 
  }
  
  public int getNumberOfPixels(){
    return pixelElements.size();
  }
  
  void display() {
    println("Cluster: " + this.id);
    for (HashMap.Entry pe : this.pixelElements.entrySet()) {
      println(pe.getKey() + " - " + pe.getValue());
    }
  }
}

class ClusterFactory {

  ArrayList<Cluster> clusterList; 
  int[][] surroundingPixels = {{-1, -1}, {0, -1}, {1, -1}, {-1, 0}, {1, 0}, {-1, 1}, {0, 1}, {1, 1}};  
  boolean foundNeighbour = false; 
  HashMap<String, Integer> visitedPixel;
  int w, h; 
  
  public ClusterFactory(int w, int h){
    this.w = w; 
    this.h = h; 
  }
  
  private boolean isVisited(int x, int y){
    String coordinates = str(x) + ":" + str(y);
    return (visitedPixel.get(coordinates) != null);
  }
  
  private void setVisited(int x, int y){
    String coordinates = str(x) + ":" + str(y);
    visitedPixel.put(coordinates, 1);
  }
  
  private boolean isValid(int x, int y){
    if (x < 0 || x > (this.w - 1)) {
      return false;
    }
    if (y < 0 || y > (this.h - 1)) {
      return false;
    }
    return true;
  }

  public ClusterCollection identifyClusters() {
    Stack<int[]> stack = new Stack<int[]>();
    clusterList = new ArrayList<Cluster>();
    visitedPixel = new HashMap<String, Integer>();
    
    loadPixels();
    
    for (int y = 0; y < height; y++ ) {
      for (int x = 0; x < width; x++) {
        
        //if pixel has color
        color col = pixels[y*width+x];
        
        if(this.isVisited(x,y)) {
          //println("Already visited (1st function)");
          continue; 
        }        
        
        if(isBackground(col)) {  
          this.setVisited(x,y);        
        } else {         
          //set pixel as visited
          this.setVisited(x,y);
          
          // create new cluster 
          int id = clusterList.size() + 1; 
          Cluster newCluster = new Cluster(width, height, id);
          newCluster.setKeyTest(x, y); 
          
          // put pixel in stack
          int[] coordinates = {x,y};
          stack.push(coordinates);
          
          // while stack non empty,
          while(!stack.isEmpty()){             
            // pop pixel off stack
            int[] currentCoordinates = stack.pop();
            this.setVisited(currentCoordinates[0], currentCoordinates[1]); 
            
            // put pixel in cluster
            newCluster.addPixel(currentCoordinates[0], currentCoordinates[1], 1);
            
            // for each of its surrounding pixels
            for(int s = 0; s < surroundingPixels.length; s++){
              int newX = currentCoordinates[0] + surroundingPixels[s][0];
              int newY = currentCoordinates[1] + surroundingPixels[s][1]; 
               
              //check if the new coordinates are valid
              if(!this.isValid(newX, newY)) {
                continue; 
              } else {
                //get the color
                color newCol = pixels[newY*width+newX];
                
                // if not visited and not background
                if((!this.isVisited(newX, newY)) && !(isBackground(newCol))) {
                  //add to the stack
                  int[] newCoordinates = {newX,newY};                  
                  stack.push(newCoordinates);
                }
              }
            }
          }
          clusterList.add(newCluster);
        }
      }
    }
    return (new ClusterCollection(clusterList)); 
  }


  void displayClusters() {
    println("You have detected " + str(clusterList.size()) + " clusters from the factory.");
  }
}



class ClusterCollection {
  ArrayList<Cluster> clusterCollection; 
  
  public ClusterCollection(ArrayList<Cluster> clusters){
    clusterCollection = clusters; 
  }
  
  public int getSize(){
   return clusterCollection.size();
  }
  
  boolean isEmpty(){
    return (clusterCollection.size() <= 0); 
  }
  
  Cluster getClusterById(int id){
    if (!isEmpty()){
      
       for(int i = 0; i < clusterCollection.size() ; i++){
        Cluster currentCluster = clusterCollection.get(i);
        if(id == currentCluster.getId()){
          return currentCluster;
        }
      }
    }
    println("cluster empty or id not found");
    return null; 
  }
  
  public ArrayList<Cluster> getClusterCollection(){
    if (clusterCollection.size() > 0){
      return clusterCollection;
    }else{
      return null; 
    }
  }
  
  public void testClusterID(){
    for(int i = 0; i < clusterCollection.size() ; i++){
          Cluster currentCluster = clusterCollection.get(i);
          println("Cluster " + i + " - Current ID: " + currentCluster.getId());
    }
  }
  
  void displayClusterCollection(){
    println("You have detected " + str(clusterCollection.size()) + " clusters from the collection.");
  }

}








//old function just in case

//void getClustersOld() {
//    loadPixels();
//    //println("Pixels length: " + pixels.length);
//    //for (int i = 0; i < pixels.length; i++ ) {
//    //  println("Pixel (" + i + "): " + hex(pixels[i], 6));
//    //}
//    for (int y = 0; y < height; y++ ) {
//      for (int x = 0; x < width; x++) {
//        //if pixel has color
//        color col = pixels[y*width+x]; 

//        this.stats(hex(col, 6));
//        if (!isBackground(col)) {
//          //println("Found pixel at '" + x + ":" + y + "' => R: " + red(col) + " G: " + green(col) +" B: " + blue(col));
//          if (clusterList.size() == 0) {
//            println("Create first cluster.");
//            Cluster newCluster = new Cluster(width, height, 1); 
//            newCluster.addPixel(x, y, 1); 
//            clusterList.add(newCluster);
//          } else {
//            foundNeighbour = false;
//            //for each cluster 
//            for (int i = 0; i < clusterList.size(); i++) {
//              Cluster currentCluster = clusterList.get(i); 

//              //check if previous neighbours colored pixel exists 
//              //if found, add pixel to the neighbour
//              //left
//              if (currentCluster.hasPixel((x - 1), y)) {
//                //print("Left pixel neighbour found.");
//                currentCluster.addPixel(x, y, 1);
//                //println(" Added to an existing cluster.");
//                foundNeighbour = true;
//              }  
//              //left top
//              if (currentCluster.hasPixel((x - 1), (y - 1))) {
//                //print("Left top pixel neighbour found.");
//                currentCluster.addPixel(x, y, 1);
//                //println(" Added to an existing cluster.");
//                foundNeighbour = true;
//              } 
//              //top
//              if (currentCluster.hasPixel(x, (y - 1))) {
//                //print("Top pixel neighbour found.");
//                currentCluster.addPixel(x, y, 1);
//                //println(" Added to an existing cluster.");
//                foundNeighbour = true;
//              }
//              //top right
//              if (currentCluster.hasPixel((x + 1), (y - 1))) {
//                //print("Top right pixel neighbour found.");
//                currentCluster.addPixel(x, y, 1);
//                //println(" Added to an existing cluster.");
//                foundNeighbour = true;
//              }
//            }
//            //else create new cluster
//            if (foundNeighbour == false) {
//              println("Create a new cluster.");
//              Cluster newCluster = new Cluster(width, height, (clusterList.size() + 1)); 
//              newCluster.addPixel(x, y, 1); 
//              clusterList.add(newCluster);
//            }
//          }
//        }
//      }
//    }
//    this.printStats();
//  } 
