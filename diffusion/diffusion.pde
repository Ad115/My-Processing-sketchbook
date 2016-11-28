float diffusionConstant = 30;
float cellSize = 25; // Size in pixels of a cell
float sourceConcentration = 100; // Concentration of chemical in the source cells
float lengthUnit = 1; // Number of pixels in a meter of simulation
float timeUnit = 1; // Number of frames per second of simulation
ChemicalField field; // The grid on wich the chemical diffuses
boolean paused;

// ADVERTENCIA: se tiene que cumplir que:
// diffusionConstant <= 1/4 *(cellSize/lengthUnit)^2 * timeUnit.

void setup()
{
  fullScreen();
  background(255);
  paused = false;
  
  // The source of the chemical
  int[] source = new int[width];
  float r = random(1000);
  for(int i=0; i<width; i++)  {  source[i] = int(height/2*noise(i*0.005 + r)); }
  
  // Initialize the chemical field
  field = new ChemicalField(cellSize, diffusionConstant, source); 
  field.draw();
}

// ******************************************************************************

void draw()
{ 
  background(255);
  if (!paused)  { field.step(); } //<>//
  field.draw();
    
  displayFrameRate();
}

// ******************************************************************************

void keyPressed() 
{ 
  // To pause the simulation
  if (key == 'p' || key == 'P')
  { paused = !paused; 
  }
  
  // To step the simulation whilst paused
  if (key == 's' || key == 'S')
  { background(255);
    field.step();
    field.draw();
  }
  
  // To reset the simulation
  if (key == 'r' || key == 'R')
    { setup(); }
}

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