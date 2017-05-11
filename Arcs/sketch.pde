Arcs arcs;
Slider slider;
int n0 = 20;
int nMin = 1;
int nMax = 25;
int sliderSize = 100;
int resetAreaRadius = 500;



void setup()
{
  size(displayWidth, displayHeight);
  frameRate(60);
  background(200);
  arcs = new Arcs(n0);
  slider = new Slider(nMin, nMax, sliderSize, n0);
}

void draw()
{
  background(200);
  
  int n = slider.draw();
  arcs.update(n);
  arcs.draw();
  
  
  fill(130, 100); ellipseMode(CENTER); noStroke();
  ellipse(width/2, height/2, 2*resetAreaRadius, 2*resetAreaRadius);
  fill(0); textSize(24);
  text("Frame rate: " + frameRate, 50, 50);
}

void mousePressed()
{
  if ( dist(mouseX, mouseY, width/2, height/2) < resetAreaRadius )
    { 
      arcs.reset();
      slider.update(random(nMin, nMax));
    }
}
