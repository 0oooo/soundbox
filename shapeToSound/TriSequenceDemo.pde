

class TriSequenceDemo implements InstrumentInterface {

    int[] midiSequence = {59, -1,  59, 57, -1, 59, 60, -1, 59, 55, 71, 51};
    int note = 0;
    SawOsc osc;
    Env env; 

    public TriSequenceDemo(PApplet parent) {
        this.osc = new SawOsc(parent);
        this.env  = new Env(parent);
    }

    public int getInstrumentId() {
        // needs to be implemented
        return 1;
    }

    public void instrumentPlay(int beat, int bar, HashMap <String, Integer> parameters) {
        println("TriSequence - beat: " + beat + " bar: " + bar);
        if(this.midiSequence[this.note] > 0) {
            this.osc.freq(midiToFreq(this.midiSequence[this.note]));
            this.env.play(this.osc, 0.0, 0.2, 0.1, 0.4);
        }

        this.note++;
        // Loop the sequence
        if (this.note == 12) {
            this.note = 0;
        }
    }
}
