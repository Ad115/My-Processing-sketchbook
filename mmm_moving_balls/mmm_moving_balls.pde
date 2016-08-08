int numSpots = 100;
Spot[] spots = new Spot[numSpots]; // Declare an array of Spot objects

void setup()
{
  fullScreen();
  int dia = width/numSpots;
  for (int i=0; i<numSpots; i++)
  {
    float x = i*dia+dia/2;
    float speed = random(-2.0, 2.0);
    spots[i] = new Spot(x, height/2, dia, speed);
  }
  noStroke();
}

void draw()
{
  fill(0, 12);
  rect(0, 0, width, height);
  fill(255);
  for (int i=0; i<numSpots; i++)
  {
    spots[i].move();
    spots[i].display();
  }
}

void keyPressed()
{
  setup();
}

class Spot
{
  float x, y;
  float diameter, speed;
  int direction = 1;
  
  //Constructor
  Spot(float pos_x, float pos_y, float d, float s)
  {
    x = pos_x; y = pos_y;
    diameter = d;
    speed = s;
  }
  
  void move()
  {
   y += (speed * direction);
   if (y > (height-diameter/2) || (y < diameter/2))
   {
     direction *= -1;
   }
  }
  
  void display()
  {
    ellipse(x, y, diameter, diameter);
  }
}