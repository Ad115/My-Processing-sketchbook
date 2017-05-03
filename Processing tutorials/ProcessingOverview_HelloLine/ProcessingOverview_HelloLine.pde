void setup()
{
  size(800, 800);
  stroke(255);
}

void draw()
{
  line(width/2, height/2, mouseX, mouseY);
}

void mousePressed()
{
  background(random(255), random(255), random(255), random(255));
}