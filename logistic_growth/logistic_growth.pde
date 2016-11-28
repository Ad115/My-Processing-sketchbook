// INCOMPLETE

final int NEIGHBORHOOD_RADIUS = 1;
final float NOISE_RATE = 0.1;

CellularAutomaton logistic;
float cellSize = 5;
float predatorDensity = 0.5;
float preyDensity = 0.5;

boolean pause, drawing; // If the user has paused the program or is drawing

void setup()
{ fullScreen();
  frameRate(30);
  predatorPrey = new CellularAutomaton(cellSize, predatorDensity, preyDensity);
  predatorPrey.draw();
  pause = false; drawing = false;
}

void draw()
{ if(!pause && !drawing)  {  predatorPrey.step(); }
  predatorPrey.draw();
  displayFrameRate();
}

void keyPressed()
{ if (key == 'r' || key == 'R')
  { predatorPrey.reset();
    predatorPrey.draw();
  }
  
  if (key == 'p' || key == 'P')  {  pause = !pause; }
  
  if (key == 's' || key == 'S')  {  predatorPrey.step(); }
  
  if (key == '+')  {  frameRate(frameRate*1.5); }
  if (key == '-')  {  if(frameRate > 1)  {frameRate(frameRate/1.5);} }
  
  if (key == 'c')  {  predatorPrey.clear(); }
  
  if (key == 'f')  {  frameRate(30); }
}

void mousePressed()  {  drawing = true; }
void mouseDragged()  {  predatorPrey.addAt(mouseX, mouseY); }
void mouseReleased()  {  drawing = false; }

void displayFrameRate()
{
  String text = "Framerate: " + frameRate;
  fill(200);
  textSize(24);
  rectMode(CORNER);
  rect(0, 0, textWidth(text)+10, 30);
  fill(0);
  text(text, 10, 24);
}
  

  
  
  