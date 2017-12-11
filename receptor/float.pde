class Bubble {
  PVector loc;
  PVector vel;  
  float mass = 1;
  int index;
  float radius;
  Interaction i;

  Bubble(PVector loc_, float radius_, int index_, Interaction i_) {
    loc = loc_;
    vel = new PVector(random(-.7, .7), random(-.7, .7));
    index = index_;
    radius = radius_;
    i = i_;
  }

  void display() {
    stroke(255);
    ellipse(loc.x, loc.y, radius * 2, radius * 2);
    fill(0);
    text(i.getTitle(), loc.x, loc.y);
  }

  void moveBubble() {
    loc.add(vel);
  }
  
  void boundaries() {
    if (loc.y < radius){
      loc.y = radius;
      vel.y *= -1;
    }if (loc.y > height - radius){
      loc.y = height - radius;
      vel.y *= -1;
    }if (loc.x > width - radius){
      loc.x = width - radius;
      vel.x *= -1;
    }if (loc.x < radius){
      loc.x = radius;
      vel.x *= -1;
    }
  }
  
  void checaToque(){
    if(mousePressed && dist(loc.x ,loc.y ,mouseX ,mouseY) < radius){
      interactions.get(index).toque();
      interacaoAtual = index;
    }
  }
}