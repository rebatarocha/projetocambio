class audioRec {
  AudioInput in;
  AudioRecorder recorder;
  boolean recorded = false;
  PApplet sketch;
  Minim minim;

  int c;

  audioRec(PApplet sketch_, int c_) {
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

  void hitRec() {
    if (!recorder.isRecording()) {
      recorder.beginRecord();
      fill(255);
      rect(0, 0, width, 110);
      fill(255, 200);
      rect(0, height/2 - 40, width, 100);
      fill(255, 0, 0);
      textFont(LatoBlack18, 20);
      text("GRAVANDO", width/2, height/2);
      fill(0);
      textFont(LatoRegular18);
      text("você pode comentar sobre como organizou os círculos também, se quiser.", width/2, height/2+20);
    } else {
      recorder.endRecord();
      recorded = true;
      saveRec();
    }
  }

  void saveRec() {
    recorder.save();
    recorded = false;
  }

  void playLastRecorded() {
    file = new SoundFile(sketch, PATH+c+".wav");
    file.play();
  }
}