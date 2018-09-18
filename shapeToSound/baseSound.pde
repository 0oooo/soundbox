import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim; 
AudioOutput out; 


// to make an Instrument we must define a class
// that implements the Instrument interface.
class SineInstrument implements Instrument
{
  Oscil wave;
  Line  ampEnv;
  
  SineInstrument( float frequency )
  {
    // make a sine wave oscillator
    // the amplitude is zero because 
    // we are going to patch a Line to it anyway
    wave   = new Oscil( frequency, 0, Waves.SINE );
    ampEnv = new Line();
    ampEnv.patch( wave.amplitude );
  }
   
  // this is called by the sequencer when this instrument
  // should start making sound. the duration is expressed in seconds.
  void noteOn( float duration )
  {
    // start the amplitude envelope
    ampEnv.activate( duration, 0.5f, 0 );
    // attach the oscil to the output so it makes sound
    wave.patch( out );
  }
  
  // this is called by the sequencer when the instrument should
  // stop making sound
  void noteOff()
  {
    wave.unpatch( out );
  }
}


float pixelToSound(){
  
  float numberOfPixel = pixelCount(); 
  //println("Number of pixel inside pixelToSound " + numberOfPixel);
  int soundValueFromGreyPixels = round(map(numberOfPixel, 0, 240000, 55, 800));
  
  //println("sound value " + soundValueFromGreyPixels);
  
  return soundValueFromGreyPixels; 
}


float[] noteToFrequency(String[] notes, String octave){
  
  float[] baseNotes = new float[12];
  
  for( int i = 0; i < notes.length; i++){
    String noteAndOctave = notes[i] + octave; 
    float freq = Frequency.ofPitch(noteAndOctave).asHz(); 
    baseNotes[i] = freq; 
  }
    return baseNotes;
}


float mapAreaToNote(String[] notes, String octave){
  //Cluster cluster1 = clusterCollection.getClusterById(1);
  //int area = cluster1.getSize(); 
  int area = pixelCount(); 
  
  float[] baseNote = noteToFrequency(notes, octave);
  // if the area is bigger or equal to the max a stack can reach, return the last note of the scale 
  if(area >= maxStackArea){
    //println("Area is bigger or equal to max. Area: " + area + ". Max Area: " + maxStackArea);
    noteUsed = notes[0];
    return baseNote[0];
  }if(area == 0){
    //println("error");
    return baseNote[0];
  }else{
    int proportion = round(maxStackArea / area);
    //println("Area: " + area + ". Max Area: " + maxStackArea + ". Difference: " + proportion);
    if(proportion >= 12){
      noteUsed = notes[11]; 
      return baseNote[11];
    }else{
      noteUsed = notes[proportion - 1];
      return baseNote[proportion - 1];
    }
  }
}
