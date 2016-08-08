CellularAutomaton life;
float cellSize = 5;
float seedProbability = 0.5;
float noiseRate = 0.3;
boolean pause, drawing; // If the user has paused the program or is drawing

void setup()
{ fullScreen();
  frameRate(30);
  life = new CellularAutomaton(cellSize, seedProbability);
  life.draw();
  pause = false; drawing = false;
}

void draw()
{ if(!pause && !drawing)  {  life.step(); }
  life.draw();
  displayFrameRate();
}

void keyPressed()
{ if (key == 'r' || key == 'R')
  { life.reset();
    life.draw();
  }
  
  if (key == 'p' || key == 'P')  {  pause = !pause; }
  
  if (key == 's' || key == 'S')  {  life.step(); }
  
  if (key == '+')  {  frameRate(frameRate*1.5); }
  if (key == '-')  {  if(frameRate > 1)  {frameRate(frameRate/1.5);} }
  
  if (key == 'c')  {  life.clear(); }
  
  if (key == 'f')  {  frameRate(30); }
}

void mousePressed()  {  drawing = true; }
void mouseDragged()  {  life.addAt(mouseX, mouseY); }
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
  

  
  
  