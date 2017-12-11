class Ball {

  int radius, index;
  PVector position;
  boolean isBlack;

  Ball(int index_, boolean isBlack_) {
    isBlack = isBlack_;
    index = index_;
    radius = int(random(5, 40));
    position = new PVector(random(width/4), random(height));
  }

  void execute1() {
    checkMouse();
    display1();
  }
  
  void execute2() {
    display2();
  }

  void checkMouse() {
    if (index == being_dragged) {
      if (!mousePressed) {
        being_dragged = -1;
      } else {
        position.x = mouseX;
        position.y = mouseY;
      }
    } else {
      if (being_dragged == -1 && mousePressed) {
        if (dist(mouseX, mouseY, position.x, position.y) < radius + 2) {
          being_dragged = index;
        }
      }
    }
  }

  void display1() {
    if(isBlack){
      stroke(255,100);
      fill(0);
    }else{
      stroke(0,100);
      fill(255);
    }
    stroke(0);
    ellipse(position.x, position.y, radius * 2, radius * 2);
  }
  
  void display2() {
    if(isBlack){
      lastPage.fill(0);
    }else{
      lastPage.fill(255);
    }
    lastPage.stroke(0);
    lastPage.ellipse(position.x, position.y, radius * 2, radius * 2);
  }
}