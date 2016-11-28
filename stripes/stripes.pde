float w, sx, sy, n = 100;

void setup()
{
  fullScreen();
  noStroke();
  fill(220, 170);
}

void draw()
{
  background(0);
  w = width/n;
  sx = floor(mouseX / w);// Find the current stripe in x
  sy = floor(mouseY / w);
  rect(sx*w, 0, w, height);
  rect(0, sy*w, width, w);
}