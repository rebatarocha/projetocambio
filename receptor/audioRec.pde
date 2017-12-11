class audioRec{
  AudioInput in;
  AudioRecorder recorder;
  boolean recorded = false;
  PApplet sketch;
  Minim minim;
  
  int c;

  audioRec(PApplet sketch_, int c_){
    sketch = sketch_;
    c = c_;
    minim = new Minim(sketch);
    // get a stereo line-in: sample buffer length of 2048
    // default sample rate is 44100, default bit depth is 16
    in = minim.getLineIn(Minim.STEREO, 2048);
    // create an AudioRecorder that will record from in to the filename specified.
    // the file will be located in the sketch's main folder.
    recorder = minim.createRecorder(in, PATH+c+".wav");
  }
  
  void hitRec(){
    if(!recorder.isRecording()){
      recorder.beginRecord();
    }else{
      recorder.endRecord();
      recorded = true;
      saveRec();
    }
  }
  
  void saveRec(){
    recorder.save();
    recorded = false;
  }
  
  void playLastRecorded(){
    file = new SoundFile(sketch,PATH+c+".wav");
    file.play();
  }
}