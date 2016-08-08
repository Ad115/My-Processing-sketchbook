PFont NR;

void setup()
{
  fullScreen();
  NR = createFont("KGNoRegretsSketch.ttf", 100);
  textFont(NR);
  textAlign(CENTER);
}

void draw()
{
  background(204);
  fill(10);
  text("AVOID", width-mouseX, height-mouseY);
  fill(100);
  text("FOLLOW", mouseX, mouseY);
}
  