final int MAX_DIFFUSION = -1;

// ADVERTENCIA: se tiene que cumplir que:
// diffusionConstant <= 1/8 *(cellSize/lengthUnit)^2 * timeUnit.

float diffusionConstant = MAX_DIFFUSION; // Let the machine calculate the maximum constant
float cellSize = 20; // Size in pixels of a cell
float sourceConcentration = 100; // Concentration of chemical in the source cells
float lengthUnit = 1; // Number of pixels in a meter of simulation
float timeUnit = 1; // Number of frames per second of simulation
SourceDistribution sources = new SourcesAtCIRCLE((float)3/4); // TOP, BOTTOM, CENTER, 
SourceDistribution sinks = new SourcesAtNOISE_VERTICAL();
ChemicalField field; // The grid on wich the chemical diffuses
boolean paused, labels, drawEllipses; // Flags for user interaction



// ******************************************************************************

void setup()
{
  fullScreen(FX2D);
  background(255);
  paused = false; labels = false; drawEllipses = false;
  
  // The source of the chemical
  int[] source = new int[width];
  float r = random(1000);
  for(int i=0; i<width; i++)  {  source[i] = int(height*noise(i*0.005 + r)); }
  
  // Initialize the chemical field








  field = new ChemicalField(cellSize, diffusionConstant, sources, sinks);  //<>//
  field.draw();
}

// ******************************************************************************

void draw()
{ 
  background(255);
  
  if (!paused)  {  field.step(); }
  field.draw();
  
  displayFrameRate();
}

// ******************************************************************************

void keyPressed() 
{ 
  // To pause the simulation
  if (key == 'p' || key == 'P')  {  paused = !paused; }
  
  // To step the simulation whilst paused
  if (key == 's' || key == 'S')
  { background(255);
    
    field.step();
    field.draw();
  }
  
  // To toogle the labels on the grid
  if (key == 'l' || key == 'L')  {  labels = !labels; }
  
  //To clear the simulation to the initial conditions
  if (key == 'c' || key == 'C')  {  field.clear(); }
  
  // To draw rectangles or ellipses
  if (key == 'e' || key == 'E')  {  drawEllipses = !drawEllipses; }
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