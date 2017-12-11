import processing.serial.*;  // serial library lets us talk to Arduino
import controlP5.*; //biblioteca pra escrever
import punktiert.math.Vec;
import punktiert.physics.*;
import ddf.minim.*;        // biblioteca que grava o áudio
import ddf.minim.ugens.*;  // biblioteca que grava o áudio
import processing.sound.*; // biblioteca para tocar o áudio gravado
import controlP5.*; //biblioteca pra escrever

XMLfile xml; // cria a variável do tipo XMLfile. esta classe contém todas as funções necessárias para manipulação de xml
String PATH = "C:/Users/Rebata Rocha/Documents/PUC/#PROJETO_FINAL/programação/posdemoday/#1cambio/emissor/data/"; // diretório a ser acessado o output

//formatação do texto
PFont LatoBlack18;
PFont LatoRegular18;
PFont CocosignumCorsivoItalicoLt18;

PImage logo; //logo Câmbio

ArrayList<Ball> balls; //ellipses do emissor
int qtd = 80; // quantidade
int being_dragged = -1;

VPhysics physics; // world object
BAttraction attr; // attractor
int amount = 200; // number of particles in the scene

int tela = 0;

boolean finalPageHasSet;
boolean textInput;
boolean textOut;
boolean recorded;

PGraphics lastPage;

String assunto = "";

audioRec audiorec; // cria a variável que grava e toca o áudio da interação. Objeto a classe audioRec possuem todas as funcionalidades necessárias para a manipulação de som captado no projeto
SoundFile file;

int count;

int rect;

ControlP5 cp5;

//BPM
Serial port;
int Sensor;      // HOLDS PULSE SENSOR DATA FROM ARDUINO
int IBI;         // HOLDS TIME BETWEN HEARTBEATS FROM ARDUINO
int BPM;         // HOLDS HEART RATE VALUE FROM ARDUINO
int[] RawY;      // HOLDS HEARTBEAT WAVEFORM DATA BEFORE SCALING
int[] ScaledY;   // USED TO POSITION SCALED HEARTBEAT WAVEFORM
int[] rate;      // USED TO POSITION BPM DATA WAVEFORM
float zoom;      // USED WHEN SCALING PULSE WAVEFORM TO PULSE WINDOW
float offset;    // USED WHEN SCALING PULSE WAVEFORM TO PULSE WINDOW
color eggshell = color(255, 253, 248);
int heart = 0;   // This variable times the heart image 'pulse' on screen
//  THESE VARIABLES DETERMINE THE SIZE OF THE DATA WINDOWS
int PulseWindowWidth = 490;
int PulseWindowHeight = 512;
int BPMWindowWidth = 180;
int BPMWindowHeight = 340;
boolean beat = false;    // set when a heart beat is detected, then cleared when the BPM graph is advanced
//MÉDIA DO BPM
int soma = 0;
int contador = 0;

// SERIAL PORT STUFF TO HELP YOU FIND THE CORRECT SERIAL PORT
String serialPort;
String[] serialPorts = new String[Serial.list().length];
boolean serialPortFound = false;
Radio[] button = new Radio[Serial.list().length*2];
int numPorts = serialPorts.length;
boolean refreshPorts = false;
//FIM BPM

void setup() {
  //size(800, 600);
  fullScreen();
  textAlign(CENTER);
  LatoBlack18 = loadFont("Lato-Black-18.vlw");
  LatoRegular18 = loadFont("Lato-Regular-18.vlw");
  CocosignumCorsivoItalicoLt18 = loadFont("CocosignumCorsivoItalico-Lt-18.vlw");
  cp5 = new ControlP5(this);
  imageMode(CENTER);
  logo = loadImage("logo2.png");
  
  //BPM
  RawY = new int[PulseWindowWidth];          // initialize raw pulse waveform array
  ScaledY = new int[PulseWindowWidth];       // initialize scaled pulse waveform array
  rate = new int [BPMWindowWidth];           // initialize BPM waveform array
  zoom = 0.75;                               // initialize scale of heartbeat window
  fill(eggshell);
  text("Select Your Serial Port", 245, 30);
  listAvailablePorts();
  port = new Serial(this, Serial.list()[0], 115200);
  serialPortFound = true;
  //FIM
  Init();
  
  
}

void draw() {
  if (tela == 0) {
    pageIntro();
  }
  // tela de instruções
  if (tela == 1) {
    pageInstructions();
  }
  // tela input de texto ( INTERAÇÃO 01)
  if (tela == 2) {
    Pagetexto();
    if(!textInput){
      textInput = true;
      cp5.addTextfield("Assunto") // Assunto da interação do usuário
        .setPosition(width/2-200, height/2-20)
        .setSize(400, 40)
        .setFont(LatoRegular18)
        .setFocus(true)
        .setColor(color(255));
    }
    assunto = cp5.get(Textfield.class, "Assunto").getText();
  }
  // tela bolas (INTERAÇÃO 02)
  if (tela == 3) {
    if(!textOut){
      cp5.get("Assunto").remove();
      textOut = true;
    }
    Pagebolas();
    noStroke();
    fill(255, 0, 0);
    ellipse(1220, 700, 20+BPM/5, 20+BPM/5);
    fill(0);
    textFont(LatoRegular18);
    text(BPM + " BPM", 1280, 707);
  }
  if (tela == 4) {
    if(!finalPageHasSet){
      finalPage();
    }
  }
  if(tela == 5){
    if(!recorded){
      int out = 0;
      if(contador != 0 ){
        out = (soma/contador);
      }
      xml.addEntry(assunto,count+".wav",count+".png",out+"");
      xml.saveXml();
      recorded = true;
    }
    image(lastPage,0,0);
    Pagefim();
  }
  if(tela == 6){
    tela = 0;
    count++;
    Init();
  }
}

void keyPressed(){
  if(key == ENTER && (tela != 3 && tela != 4)){
    tela++;
  }
  
  if((tela == 3 || tela == 4) && key == 'r'){
    audiorec.hitRec();
    tela++;
  }
}