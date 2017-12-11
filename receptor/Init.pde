void Init(PApplet sketch) {
  
  interacaoAtual = -1;
  
  minim = new Minim(sketch);

  tocar = "";
  texto = "";
  mostrar = null;

  en_click = true;
  playScreen = false;

  xml = new XMLfile(PATH+"cambio.xml", sketch); // inicialização da variável xml como um novo XMLfile

  Childs = xml.getInteractions();
  interactions = new ArrayList<Interaction>();
  println(Childs.length+" interactions");
  for (int i = 0; i < Childs.length; i++) {
    interactions.add(new Interaction(Childs[i].getChild("audio").getContent(), Childs[i].getChild("image").getContent(), Childs[i].getChild("title").getContent(), parseInt(Childs[i].getChild("bpm").getContent()), new PVector(30, 100 + i * 60), this));
  }
  physics = new VPhysics(); //particulas
  physics.setfriction(.50f);

  // new AttractionForce: (Vec pos, radius, strength)
  attr = new BAttraction(new Vec(width * .200f, height * .200f), 50, .1f);
  physics.addBehavior(attr);

  for (int i = 0; i < amount; i++) {
    // val for arbitrary radius
    float rad = random(2, 20);
    // vector for position
    Vec pos = new Vec(random(rad, width - rad), random(rad, height - rad));
    // create particle (Vec pos, mass, radius)
    VParticle particle = new VParticle(pos, 20, rad);
    // add Collision Behavior
    particle.addBehavior(new BCollision());
    // add particle to world
    physics.addParticle(particle);
  }

  for (int i = 0; i < Childs.length; i++) {
    bubbles.add(new Bubble(new PVector(random(width), random(height)), random(25, 35), i, interactions.get(i)));
  }
}