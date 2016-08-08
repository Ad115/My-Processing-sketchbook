Car myCar;

void setup()
{
  myCar = new Car();
}

void draw()
{
  background(255);
  myCar.drive();
  myCar.display();
}

class Car
{
  color c;
  float x, y;
  float vx, vy;
  
  Car()
  {
    c = color(0);
    x = width/2;
    y = height/2;
    vx = 3;
    vy = 1;
  }
  
  void display()
  {
   rectMode(CENTER);
   fill(c);
   rect(x, y, 20, 20);
  }
  
  void drive()
  {
    drivex();
    drivey();
  }
  
  void drivex()
  {
    float x0;
    x0 = x + vx;
    if (x0+10 > width || x0 < 10)
    {
      vx = -vx;
      x = x + vx;
    }
    else 
    {
      x = x0;
    }
  }
  
  void drivey()
  {
    float y0;
    y0 = y + vy;
    if (y0+10 > height || y0 < 10)
    {
      vy = -vy;
      y = y + vy;
    }
    else 
    {
      y = y0;
    }
  }
}