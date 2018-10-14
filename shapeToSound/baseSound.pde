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
