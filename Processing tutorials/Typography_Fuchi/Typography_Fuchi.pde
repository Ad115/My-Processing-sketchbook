float x, y, bg = random(255);
PFont NR, NRSolid;
String s = "..fuchi, fuuchi ¬¬";

void setup()
{
  fullScreen();
  background(bg);
  NR = createFont("KGNoRegretsSketch.ttf", 100);
  NRSolid = createFont("KGNoRegretsSolid.ttf", 50);
  textFont(NRSolid);
  textAlign(CENTER);
  noStroke();
}

void draw()
{
  x=width-mouseX; y=height-mouseY;
  fill(bg, 120);
  rect(0, 0, width, height);
  fill(0);
  float w = textWidth(s);
  if ((mouseX >= x-w/2) && (mouseX <= x+w/2) &&
        (mouseY >= y-100) && (mouseY <= y))
        {
          x += random(-20,20);
          y += random(-20, 20);
          s = "FUUUUUCHII!!! D8";
          textFont(NR);
        }
  else
  {
    s = "..fuchi, fuchi :S";
    textFont(NRSolid);
  }
  text(s, x, y);
}

void keyPressed()
{
  bg =random(255);
  x = random(width); y = random(height);
}