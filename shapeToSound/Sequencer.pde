/*

  Sequencer Class

  Creates an sequence set of beats and bars and notifies an intruments that implement the SequencerObserverInterface
  See TriSequenceDemo.pde for an example instrument.

  Example Setup:

  // 200 is the interval between beats in milliseconds
  Sequencer sequencer = new Sequencer(200);
  TriSequenceDemo triSequencerInstrument;

  void setup() {
     // This instrument implements the SequencerObserverInterface
     triSequencerInstrument = new TriSequenceDemo(this);

     // Tell the instrument to listen to the sequencer
     sequencer.addObserver(triseq);
  }
  void draw() {
    // Call during the draw function so that the sequencer can iterate
    sequencer.tick();
  }

*/
class Sequencer {

    private int trigger = 0;
    private int interval = 200;
    private int bar = 1;
    private int beat = 0;
    private boolean debug = false;
    private ArrayList<SequenceObserver> observers = new ArrayList<SequenceObserver>();

    public Sequencer(int interval) {
        this.interval = interval;
    }

    public Sequencer(int interval, boolean debug) {
        this.interval = interval;
        this.debug = debug;
    }

    public void addObserver(SequenceObserver observers) {
        this.observers.add(observers);
    }

    public void removeObserver(SequenceObserver observers) {
        for (int i = 0; i < this.observers.size(); i++) {
            if(this.observers.get(i).getObserverId() == observers.getObserverId()) {
                this.observers.remove(i);
            }
        }
    }

    public void tick() {
        int time = millis();

        if (time >= this.trigger) {
            trigger = time + this.interval;

            this.beat++;
            if (this.beat > 4) {
                this.beat = 1;
                this.bar++;
            }
            if(this.bar > 4) {
                this.bar = 1;
            }

            if(this.debug) {
                println("Beat:" + this.beat);
                println("Bar:" + this.bar);
            }

            this.notifyObservers(this.beat, this.bar);
        }
    }

    private void notifyObservers(int beat, int bar) {
        println("Notifying Observers:" + this.observers.size());

        for (int i = 0; i < this.observers.size(); i++) {
            if(this.debug) {
                println("observer:" + this.observers.get(i).getObserverId() + " is being notified.");
            }
            this.observers.get(i).observerPlay(beat, bar);
        }
    }
}