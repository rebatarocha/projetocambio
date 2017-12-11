void finalPage(){
  lastPage = createGraphics(width,height);
  lastPage.beginDraw();
  for (int i = qtd-1; i >= 0; i--) {
    Ball b = balls.get(i);
    b.execute2();
  }
  lastPage.endDraw();
  lastPage.save("data/"+count+".png");
}