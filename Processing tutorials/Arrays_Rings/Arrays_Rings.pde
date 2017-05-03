Ring[] rings; // Declare an array of Ring objects
int numRings = 50;
int currentRing = 0;

void setup()
{
  fullScreen();
  rings = new Ring[numRings]; // Create the array
  for (int i=0; i<rings.length; i++)
  {
    rings[i] = new Ring();
  }
}

void draw()
{
  background(0);
  for (int i=0; i<rings.length; i++)
  {
    rings[i].grow();
    rings[i].display();
  }
}


// Click creates a new Ring
void mousePressed()
{
  rings[currentRing].start(mouseX, mouseY);
    currentRing++;
    if (currentRing >= numRings)
    {
      currentRing = 0;
    }
}

class Ring
{
  float x, y;
  float diameter;
  boolean on = false;
  
  void start(float pos_x, float pos_y)
  {
    x = pos_x;
    y = pos_y;
    
    diameter = 1;
    on = true;
  }
  
  void grow()
  {
    if (on == true)
    {
      diameter += 2;
      if (diameter > 600)
      {
        diameter = 1;
        on = false;
        
      }
    }
  }
  
  void display()
  {
    if (on == true)
    {
      noFill();
      strokeWeight(4);
      stroke(204, 153);
      ellipse(x, y, diameter, diameter);
    }
  }
}