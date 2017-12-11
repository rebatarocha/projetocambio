void Init(){
  recorded = false;
  finalPageHasSet = false;
  textInput = false;
  textOut = false;
  soma = 0;
  contador = 0;

  being_dragged = -1;
  
  xml = new XMLfile(PATH+"cambio.xml"); // inicialização da variável xml como um novo XMLfile
  count = xml.countInteractions();
  println(xml.countInteractions()+" interactions registered");
  audiorec = new audioRec(this, count);

  balls = new ArrayList<Ball>();  // Start by adding one element
  for (int i = 0; i < qtd/2; i++) {
    balls.add(new Ball(i,false));
  }
  for (int i = qtd/2; i < qtd; i++) {
    balls.add(new Ball(i,true));
  }

  physics = new VPhysics(); //particulas
  physics.setfriction(.4f);

  // new AttractionForce: (Vec pos, radius, strength)
  attr = new BAttraction(new Vec(width * .5f, height * .200f), 100, .50f);
  physics.addBehavior(attr);

  for (int i = 0; i < amount; i++) {
    // val for arbitrary radius
    float rad = random(5, 20);
    // vector for position
    Vec pos = new Vec(random(rad, width - rad), random(rad, height/2 - rad/5));
    // create particle (Vec pos, mass, radius)
    VParticle particle = new VParticle(pos, 20, rad);
    // add Collision Behavior
    particle.addBehavior(new BCollision());
    // add particle to world
    physics.addParticle(particle);
  }
}