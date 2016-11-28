Fractal julia = new Fractal();

void setup()
{
  fullScreen();
  background(0);
  julia.init(width, height);
}

void draw()
{
  displayFrameRate();
  julia.update(); //<>//
  julia.draw();
}

void displayFrameRate()
{
  String text = "Framerate: " + frameRate;
  fill(200);
  textSize(12);
  rectMode(CORNER);
  rect(0, 0, textWidth(text)+10, 15);
  fill(0);
  text(text, 10, 12);
}