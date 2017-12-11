import processing.sound.*;

class Interaction {

  PVector posicao;
  PApplet sketch;
  String audio, imagem, titulo; 
  int bpm;
  boolean carregado = false;

  Interaction(String _audio, String _imagem, String _titulo, int _bpm, PVector _posicao, PApplet _sketch) {
    audio = _audio; 
    imagem = _imagem;
    titulo = _titulo;
    bpm = _bpm;
    posicao = _posicao;
    sketch = _sketch;
  }

  String getAudio() {
    return audio;
  }

  String getImage() {
    return imagem;
  }

  String getTitle() {
    return titulo;
  }

  int getBpm() {
    return bpm;
  }

  PVector getPosicao() {
    return posicao;
  }

  void toque() {
    tocar = getAudio();
    mostrar = loadImage(PATH + getImage());
    titulo = getTitle();
    bpm = getBpm();
    int_sound = minim.loadSample( PATH+tocar, 512);
    texto = getTitle() + " " + getBpm() + "BPM";
    tela++;
  }
}