Walker[] w = new Walker[50];
int alpha = 100;

void setup()
{
  fullScreen();
  for (int i=0; i<w.length; i++)
  {
    w[i] = new Walker();
  }
  background(255);
  noFill();
  stroke(150);
  strokeWeight(4);
  int n = 10;
  float d = width/(n+1); 
  for (int i=1; i<=n; i++)
  {
    ellipse(width/2, height/2, d*i, d*i);
  }
}

void draw()
{
  for (int i=0; i<w.length; i++)
  {
    w[i].walk();
  }
}

void keyPressed()
{
  setup();
}

class Walker
{
  float x, y;
  float step, radius;
  float t, dist_ratio;
  int[] distribution = new int[700];
  int[]  fill = new int[3];
  
  Walker()
  {
    x = width/2;
    y = height/2;
    step = 7;
    radius = 7;
    t = 0;
    for (int i=0; i<distribution.length; i++)
    {
      distribution[i] = 0;
    }
    for (int i=0; i<fill.length; i++)
    {
      fill[i] = int(random(255));
    }

  }
  
  void walk()
  {
    step();
    display();
  }
  
  void display()
  {
    noStroke();
    fill(fill[0], fill[1], fill[2], alpha);
    ellipse(x,y, radius, radius);
    float gwidth = width, gheight = height-50;
    int l = distribution.length;
    float w = gwidth/l;
    for (int i=0; i<l; i++)
    {
      float h = distribution[i];
      rect(w*i, gheight-h, w, h);
    }
    fill(255);
    rect(width-200, 0, 200, 50);
    fill(0);
    text(dist_ratio/10, width-200, 20);
  }
  
  void step()
  {
    float stepx = random(-1, 1);
    float stepy = random(-1, 1);
    x += stepx * step;
    y += stepy * step; 
    t++;
    float distance = dist(x, y, width/2, height/2);
    dist_ratio = (distance*distance)/(t);
    dist_ratio = map(dist_ratio, 0, 100, 0, distribution.length);
    if(dist_ratio<distribution.length)
    {
      distribution[int(dist_ratio)]++;
    }
  }
  
  void reset()
  {
    x = width/2;
    y = width/2;
  }
}