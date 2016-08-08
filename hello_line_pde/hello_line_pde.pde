void setup()
{
  size(400, 400);
  stroke(255);
}

void draw()
{
  line(width/2, height/2, mouseX, mouseY);
}

void mousePressed()
{
  background(192, 64, 0);
}