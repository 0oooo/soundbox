class BaseSound implements InstrumentInterface {

  SawOsc osc;
  Env env; 

  public BaseSound(PApplet parent) {
    this.osc = new SawOsc(parent);
    this.env  = new Env(parent);
  }

  public int getInstrumentId() {
    // needs to be implemented
    return 1;
  }

  public void instrumentPlay(int beat, int bar, HashMap<String, Integer> parameters) {
    println("TriSequence - beat: " + beat + " bar: " + bar);
    if(beat == 1){
      this.osc.freq(
        midiToFreq(
          mapAreaToMidiNote(
            parameters.get("clusterArea"), 
            parameters.get("w"), 
            parameters.get("h")
           )
          )
         );
      this.env.play(this.osc, 0.0, 0.2, 0.1, 0.4);
    }
  }

  // This function maps the area of a cluster to a midi note.
  // The maximum area for a cluster in theory would be the area of the box
  // We divide that area by the number of clusters 
  // to give each clusters the same max area they can extend to
  // The starting midi notes are 60 to 72 
  public int mapAreaToMidiNote(int clusterArea, int w, int h) {
    int maxArea = w * h; 
    int maxAreaPerCluster = maxArea / 4; 
    int midiNote = round(map(clusterArea, 0, maxAreaPerCluster, 60, 72)); 
    println("+++++++++++++++++++++++++++++++++++++++++++++++");
    println("Current area of the cluster 1: " + clusterArea); 
    println("Note played is : " + midiNote); 
    println("+++++++++++++++++++++++++++++++++++++++++++++++");
    return midiNote;
  }
}

// This function calculates the respective frequency of a MIDI note
float midiToFreq(int note) {
  return (pow(2, ((note-69)/12.0)))*440;
}


//float pixelToSound(){

//  float numberOfPixel = pixelCount(); 
//  //println("Number of pixel inside pixelToSound " + numberOfPixel);
//  int soundValueFromGreyPixels = round(map(numberOfPixel, 0, 240000, 55, 800));

//  //println("sound value " + soundValueFromGreyPixels);

//  return soundValueFromGreyPixels; 
//}


//float[] noteToFrequency(String[] notes, String octave){

//  float[] baseNotes = new float[12];

//  for( int i = 0; i < notes.length; i++){
//    String noteAndOctave = notes[i] + octave; 
//    float freq = Frequency.ofPitch(noteAndOctave).asHz(); 
//    baseNotes[i] = freq; 
//  }
//    return baseNotes;
//}

//float mapAreaToNote(String[] notes, String octave){
//  //Cluster cluster1 = clusterCollection.getClusterById(1);
//  //int area = cluster1.getSize();
//  int area = pixelCount(); 

//  float[] baseNote = noteToFrequency(notes, octave);
//  // if the area is bigger or equal to the max a stack can reach, return the last note of the scale 
//  if(area >= maxStackArea){
//    //println("Area is bigger or equal to max. Area: " + area + ". Max Area: " + maxStackArea);
//    noteUsed = notes[0];
//    return baseNote[0];
//  }if(area == 0){
//    //println("error");
//    return baseNote[0];
//  }else{
//    int proportion = round(maxStackArea / area);
//    //println("Area: " + area + ". Max Area: " + maxStackArea + ". Difference: " + proportion);
//    if(proportion >= 12){
//      noteUsed = notes[11]; 
//      return baseNote[11];
//    }else{
//      noteUsed = notes[proportion - 1];
//      return baseNote[proportion - 1];
//    }
//  }
//}
