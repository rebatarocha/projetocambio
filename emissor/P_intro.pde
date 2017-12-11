void pageIntro() {
  background(255);
  physics.update();

  noFill();
  // set pos to mousePosition
  attr.setAttractor(new Vec(mouseX, mouseY));
  ellipse(attr.getAttractor().x, attr.getAttractor().y, attr.getRadius(), attr.getRadius());

  noStroke();
  fill(0, 200);
  for (VParticle p : physics.particles) {
    ellipse (p.x, p.y, p.getRadius() * 2, p.getRadius() * 2);
    //}
  }
  image(logo, width/2, height/2, width, 800);
  textFont(LatoRegular18);
  fill(0);
  text("Se pudesse colocar alguém no seu ponto de vista por um tempo, o que mostraria a ela? ", width/2, 510);
  textFont(LatoBlack18);
  text("APERTE 'ENTER' PARA INICAR A EXPERIÊNCIA", width/2, 650);
}