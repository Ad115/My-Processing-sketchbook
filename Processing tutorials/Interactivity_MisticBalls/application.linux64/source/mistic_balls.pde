void setup()
{
  fullScreen();
  noStroke();
}

void draw()
{
  background(126);
  if(mouseY < height/2)
  {
    fill(255, 150);
    ellipse(mouseX, height/2, mouseY, mouseY);
    fill(0, 150);
    ellipse(width-mouseX, height/2, height-mouseY, height-mouseY);
  }
  else
  {
    fill(0, 150);
    ellipse(width-mouseX, height/2, height-mouseY, height-mouseY);
    fill(255, 150);
    ellipse(mouseX, height/2, mouseY, mouseY);
  }
}