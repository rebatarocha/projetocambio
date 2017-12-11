void listAvailablePorts() {
  println(Serial.list());    // print a list of available serial ports to the console
  serialPorts = Serial.list();
  fill(0);
  //textFont(font, 16);
  textAlign(LEFT);
  // set a counter to list the ports backwards
  int yPos = 0;
  int xPos = 35;
  for (int i=serialPorts.length-1; i>=0; i--) {
    button[i] = new Radio(xPos, 95+(yPos*20), 12, color(180), color(80), color(255), i, button);
    text(serialPorts[i], xPos+15, 100+(yPos*20));

    yPos++;
    if (yPos > height-30) {
      yPos = 0; 
      xPos+=200;
    }
  }
  int p = numPorts;
  fill(233, 0, 0);
  button[p] = new Radio(35, 95+(yPos*20), 12, color(180), color(80), color(255), p, button);
  text("Refresh Serial Ports List", 50, 100+(yPos*20));

  //textFont(font);
  textAlign(CENTER);
} 