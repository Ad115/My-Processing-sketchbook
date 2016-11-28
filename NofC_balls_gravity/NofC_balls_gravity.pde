Balls balls;
Liquid liquid;
Attractor attractor;
float viscosity = 1;
float charge = 1000;
int n_balls = 100;
float r = 20;
boolean background = true;
boolean paused = false;


void setup()
{
  fullScreen();
  background(255);
  
  liquid = new Liquid(-width, height/2-50, 3*width/2, 200, viscosity);
  attractor = new Attractor(charge);
  balls = new Balls(n_balls);
  attractor.draw();
  liquid.draw();
  balls.draw();
}

void draw()
{
  if (!paused) 
  {
    if (background) { background(255); }
    balls.update();
    liquid.drag(balls);
    attractor.attract(balls);
    attractor.draw();
    liquid.draw();
    balls.draw();
    displayFrameRate();
  }
}

void keyPressed()
{
  if (key == 'r') { balls.randomize(r); }
  if (key == 'b') { background = !background; }
  if (key == 'p') { paused = !paused; }
  if (key == 's') { setup(); }
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