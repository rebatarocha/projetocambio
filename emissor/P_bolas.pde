void Pagebolas() {
  background(250);

  for (int i = qtd-1; i >= 0; i--) {
    Ball b = balls.get(i);
    b.execute1();
  }
  noStroke();
  fill(255);
  rect(0, 0, width, 110);
  textFont(LatoRegular18);
  fill(0);
  text("Organize os elementos da tela para expressar sua opinião sobre '" + assunto+ "'.", width/2, 50);
  textFont(LatoRegular18, 16);
  text("Quando terminar, aperte a tecla 'r' para gravar o áudio", width/2, 80);
}