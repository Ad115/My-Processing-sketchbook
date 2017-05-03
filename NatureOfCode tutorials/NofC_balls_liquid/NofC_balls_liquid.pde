Balls balls;
Liquid liquid;
Something something;
float viscosity = 1;
int n_balls = 500;
float r = 20;
boolean background = true;
boolean paused = false;


void setup()
{
  fullScreen();
  background(255);
  
  liquid = new Liquid(-width, height/2-50, 3*width/2, 200, viscosity);
  balls = new Balls(n_balls);
  liquid.draw();
  balls.draw();
  something = Something.makeSomething(0); // To test whether static methods work
}

void draw()
{
  if (!paused) 
  {
    if (background) { background(255); }
    balls.update();
    liquid.drag(balls);
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
  println(something.i);
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