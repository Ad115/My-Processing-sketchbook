float x = random(width), y = random(height);
float bg = random(255);
PFont NR, NRSolid;
String s = "..miedito...";

void setup()
{
  fullScreen();
  background(bg);
  NR = createFont("KGNoRegretsSketch.ttf", 100);
  NRSolid = createFont("KGNoRegretsSolid.ttf", 100);
  textFont(NRSolid);
  noStroke();
}

void draw()
{
  fill(bg, 120);
  rect(0, 0, width, height);
  fill(0);
  if ((mouseX >= x) && (mouseX <= x+textWidth(s)) &&
        (mouseY >= y-100) && (mouseY <= y))
        {
          x += random(-10,10);
          y += random(-10, 10);
          s = "MIEDOOTEE!";
          textFont(NR);
        }
  else
  {
    s = "..miedito...";
    textFont(NRSolid);
  }
  text(s, x, y);
}

void keyPressed()
{
  bg =random(255);
  x = random(width); y = random(height);
}