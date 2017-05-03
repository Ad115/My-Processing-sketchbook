Balls balls;
int n_balls = 100;
float r = 20;
boolean background = false;
boolean paused = false;


void setup()
{
  fullScreen();
  background(255);
  
  balls = new Balls(n_balls);
  balls.draw();
}

void draw()
{
  if (!paused) 
  {
    if (background) { background(255); }
    balls.update();
    balls.move();
    balls.draw();
  }
}

void keyPressed()
{
  if (key == 'r') { balls.randomize(r); }
  if (key == 'b') { background = !background; }
  if (key == 'p') { paused = !paused; }
}