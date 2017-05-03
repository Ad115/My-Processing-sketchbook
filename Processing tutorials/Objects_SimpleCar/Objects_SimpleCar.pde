color c = color(0);
float x = 0;
float y = 100;
float speed = 1;

void setup()
{
  size(200, 200);
}

void draw()
{
  background(255);
  move();
  display();
}

void move()
{
  x = x+ speed;
  if (x+30 > width || x < 0)
  {
    speed = -speed;
  }
}

void display()
{
  fill(c);
  rect(x,y,30,10);
}