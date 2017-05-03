void setup()
{
  fullScreen();
  fill(0,50);
  rectMode(CENTER);
  background(150);
}

void draw()
{}

void mouseMoved()
{
  rect(mouseX, mouseY, random(100), random(100));
}

void keyPressed()
{
  background(random(255));
}