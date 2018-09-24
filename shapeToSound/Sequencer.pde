/*

  Sequencer Class

  Creates an sequence set of beats and bars and notifies an intruments that implement the SequencerObserverInterface
  See TriSequenceDemo.pde for an example instrument.

  Example Setup:

  // 200 is the interval between beats in milliseconds
  Sequencer sequencer = new Sequencer(200);
  TriSequenceDemo triSequencerInstrument;
  HashMap<Integer, Integer> parameters = new HashMap<Integer, Integer>
  hm = [1=>2345, 2=>234, id=>area]
  
  void setup() {
     // This instrument implements the SequencerObserverInterface
     triSequencerInstrument = new TriSequenceDemo(this);

     // Tell the instrument to listen to the sequencer
     sequencer.addObserver(triSequencerInstrument);
  }
  void draw() {
    // do c stuff
    
    // Call during the draw function so that the sequencer can iterate
    sequencer.tick(parameters);
  }

*/

class Sequencer {

    private int trigger = 0;
    private int interval = 200;
    private int bar = 1;
    private int beat = 0;
    private boolean debug = false;
    private HashMap<Integer, InstrumentInterface> observers = new HashMap<Integer, InstrumentInterface>();

    public Sequencer(int interval) {
        this.interval = interval;
    }

    public Sequencer(int interval, boolean debug) {
        this.interval = interval;
        this.debug = debug;
    }

    public void addObserver(InstrumentInterface observer, int id) {
        observers.put(id, observer);
    }

    public void tick(HashMap<Integer, Integer> parameters) {
        int time = millis();

        if (time >= trigger) {
            trigger = time + interval;

            beat++;
            if (beat > 4) {
                beat = 1;
                bar++;
            }
            if(bar > 4) {
                bar = 1;
            }

            if(debug) {
                println("Beat:" + beat);
                println("Bar:" + bar);
            }

            notifyObservers(beat, bar, parameters);
        }
    }

    private void notifyObservers(int beat, int bar, HashMap<Integer, Integer> parameters) {
      int w = width; 
      int h = height; 
        println("Notifying Observers:" + observers.size());
        
        //first cluster => sound base
        if(parameters.get(1) != null){
          HashMap<String, Integer> parameterForBaseSound = new HashMap<String, Integer>(); 
          int clusterArea = parameters.get(1); 
          parameterForBaseSound.put("w", w); 
          parameterForBaseSound.put("h", h); 
          parameterForBaseSound.put("clusterArea", clusterArea); 
          
          observers.get(1).instrumentPlay(beat, bar, parameterForBaseSound);
        }
        
        //TODO: Verify what info needs to be passed for the tempo and arpegio and delete useless ones
        //second cluster => tempo
        if(parameters.get(2) != null){
          HashMap<String, Integer> parameterForBaseSound = new HashMap<String, Integer>(); 
          int clusterArea = parameters.get(2); 
          parameterForBaseSound.put("w", w); 
          parameterForBaseSound.put("h", h); 
          parameterForBaseSound.put("clusterArea", clusterArea); 
          //TO DO : uncomment when 2nd and 3rd instrument exists and are implemented
          //observers.get(2).instrumentPlay(beat, bar, parameterForBaseSound);
        }
       
        
        //third cluster => arpegio
        if(parameters.get(3) != null){
          HashMap<String, Integer> parameterForBaseSound = new HashMap<String, Integer>(); 
          int clusterArea = parameters.get(3); 
          parameterForBaseSound.put("w", w); 
          parameterForBaseSound.put("h", h); 
          parameterForBaseSound.put("clusterArea", clusterArea); 
          
          //observers.get(3).instrumentPlay(beat, bar, parameterForBaseSound);
        }
        //for (int i = 0; i < observers.size(); i++) {
        //    if(debug) {
        //        println("observer:" + observers.get(i).getObserverId() + " is being notified.");
        //    }
        //    observers.get(i).observerPlay(beat, bar);
        //}
    }
}
