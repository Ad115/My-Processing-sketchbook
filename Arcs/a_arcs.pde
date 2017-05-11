class Arcs
{
  int t, n;
  float wiggleRate = 0.01;
  float unitOffWiggle = 3;
  float shadeRate = 0.03;
  float unitOffShade = 4;
  float shadeAmp = 75;
  
  Arcs(int n)
  {
    this.n = n;
    this.t = int(random(1000));
  }
  
  void draw()
  {
    int size;
    if (width > height) 
      {size = (height - 50);}
    else 
      {size = (width - 50);}
      
    int offShade=0;
    int offWiggle=0;
    int w = size/n;
    for(int s=size; s>0; s -= w)
    {
      // Draw circle
      ellipseMode(CENTER);
      stroke(100); noFill(); strokeWeight(10);
      ellipse(width/2, height/2, s, s);
      
      // Draw arc
      stroke(0, 130);
      strokeWeight(shadeAmp*noise(100+(t+offShade)*shadeRate));
      float a = noise((t+offWiggle)*wiggleRate);
      a = map(a, 0, 1, 0, 2*TAU);
      float b = noise(1000 + (t+offWiggle)*wiggleRate);
      b = map(b, 0, 1, 0, TAU);
      arc(width/2, height/2, s, s, a, a+b);
      
      offShade += unitOffShade;
      offWiggle += unitOffWiggle;
    }
    t+=1;
  }
    
  void reset() 
  { 
    this.t = int(random(1000));
  }
    
  void update(int n) { this.n = n; }

}

//====================================================

class Slider
{
  float value;
  float min;
  float max;
  int size;

  
  Slider(float min, float max, int size, float initial)
  {
    this.min = min;
    this.max = max;
    this.size = size;
    this.value = initial;
  }
  
  int draw()
  {
    // Update value if necessary
    if (mousePressed) { update(); }
    
    ellipseMode(CORNER);
    noStroke();
    
    // Draw slider bar
    fill(100, 100);
    rect(0, height - size, width, size);
    
    // Draw slider
    float x = map(value, min, max, 0, width) - size/2;
    fill(0, 200);
    ellipse(x, height-size, size, size);
    fill(255, 200); textSize(size);
    text(value, x, height-4);
    
    return int(value);
  }
  
  void update()
  {
    // Check if mouse is over the slider
    if( (height-size < mouseY) && (mouseY < height) )
    {
      // Update the slider value
      value = map(mouseX, 0, width, min, max);
    }
  }
  
  void update(float value)
  {
    this.value = value;
  }
  
}

//====================================================

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