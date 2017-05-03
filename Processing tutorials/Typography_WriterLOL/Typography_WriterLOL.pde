String letters = "";

void setup()
{
  fullScreen();
  stroke(255);
  fill(0);
  PFont noRegrets = createFont("KGNoRegretsSketch.ttf", 32);
  textFont(noRegrets);
  textSize(32);
}

void draw()
{
  background(204);
  float cursorPosition = textWidth(letters);
  line(cursorPosition, 0, cursorPosition, height);
  text(letters, 0, 50);
}

void keyPressed()
{
  if (key == BACKSPACE)
  {
    if (letters.length() > 0)
    {
      letters = letters.substring(0, letters.length()-1);
    }
  }
  else if (textWidth(letters + key) < width)
  {
    letters = letters + key;
  }
}