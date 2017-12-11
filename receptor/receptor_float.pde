import punktiert.math.Vec;
import punktiert.physics.*;
import ddf.minim.*;        // biblioteca que grava o áudio
import ddf.minim.ugens.*;  // biblioteca que grava o áudio
import processing.sound.*; // biblioteca para tocar o áudio gravado
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

XMLfile xml; // cria a variável do tipo XMLfile. esta classe contém todas as funções necessárias para manipulação de xml
String PATH = "C:/Users/Rebata Rocha/Documents/PUC/#PROJETO_FINAL/programação/posdemoday/#1cambio/emissor/data/"; // diretório a ser acessado o output
//formatação do texto
PFont LatoBlack18;
PFont LatoRegular18;
PFont CocosignumCorsivoItalicoLt18;

PImage logo; //logo Câmbio

VPhysics physics; // world object
BAttraction attr; // attractor
int amount = 200; // number of particles in the scene

int tela = 0;

String tocar, texto;
PImage mostrar;

SoundFile file;

ArrayList<Interaction> interactions;

XML[] Childs;

boolean en_click;
boolean playScreen;

Minim minim;

AudioSample int_sound;

ArrayList bubbles = new ArrayList();
boolean lines = true;
boolean clickOnce;

int interacaoAtual;

void setup() {
  //size(800, 600);
  fullScreen();
  textAlign(CENTER);
  LatoBlack18 = loadFont("Lato-Black-18.vlw");
  LatoRegular18 = loadFont("Lato-Regular-18.vlw");
  CocosignumCorsivoItalicoLt18 = loadFont("CocosignumCorsivoItalico-Lt-18.vlw");
  Init(this);
}

void draw() {
  if (tela == 0) {
    //exibir as interações
    background(0);
    for (int i = 0; i < interactions.size() && i < bubbles.size() ; i++) {
      fill(255);
      Bubble b = (Bubble) bubbles.get(i);
      b.display();
      b.moveBubble();
      b.boundaries();
      b.checaToque();
    }
  }

  if (tela == 1) {
    background(255);
    physics.update();

    noFill();
    // set pos to mousePosition
    attr.setAttractor(new Vec(mouseX, mouseY));
    ellipse(attr.getAttractor().x, attr.getAttractor().y, attr.getRadius(), attr.getRadius());

    noStroke();
    fill(0, 50);
    for (VParticle p : physics.particles) {
      float s = 0;
      for ( int i = 0; i < int_sound.bufferSize(); i++ ) {
        s += abs( int_sound.mix.get( i )/8);
      }
      ellipse (p.x, p.y, (interactions.get(interacaoAtual).getBpm()/5) + (p.getRadius()/5) + s, (interactions.get(interacaoAtual).getBpm()/5) + (p.getRadius()/2) + s);
    }
    if (!playScreen) {
      playScreen = true;
      int_sound.trigger();
    }
    image(mostrar, 0, 0);
    fill(0);
    text(texto, 100, 100);
    // exibe a interação escolhida
  }
  if (tela >= 2) {
    int_sound.stop();
    tela=0;
    Init(this);
  }
  if (!mousePressed) {
    en_click = true;
  }
}

void keyPressed() {
  if (tela == 1 && key == ENTER) {
    tela++;
  }
}