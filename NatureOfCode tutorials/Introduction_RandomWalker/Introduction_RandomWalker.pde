import java.util.Random;
Random generator;
float spread = 20;
Walker[] w = new Walker[500];
float size = 4;
Histogram histogram;
int alpha = 100;
boolean loop = true;
float bg;


void setup()
{
  // Setup
  fullScreen();
  bg = random(255);
  generator = new Random();
  
  // Background
  background(bg);
  noFill();
  stroke(150);
  strokeWeight(4);
  int n = 10;
  float d = width/(n+1); 
  for (int i=1; i<=n; i++)
  {
    ellipse(width/2, height/2, d*i, d*i);
  }
  
  //Initialization
  for (int i=0; i<w.length; i++)
  {
    w[i] = new Walker();
  }
  histogram = new Histogram(1000, 0, width, width, height/4, bg);
}

void draw()
{
  // Display walkers
  for (int i=0; i<w.length; i++)
  {
    w[i].walk();
  }
  
  // Display distribution
  histogram.display();
}

void keyPressed()
{
  if((key=='P') || (key=='p') || (key==' '))
  {
    loop = !loop;
    if(loop) {loop();}
    else {noLoop();}
  }
  
  if((key=='R') || (key=='r'))
  {
    setup();
  }
  
  if (key == 'b' || key == 'B') { background(bg); }
}

class Walker
{
  float x, y;
  float step, radius;
  float dist_ratio;
  int fill = int(random(255));
  
  Walker()
  {
    x = width/2 + (float)generator.nextGaussian()*spread; // random(height);
    y = height/2 + (float)generator.nextGaussian()*spread; // random(height);
    step = size * (1 + 0.3 * (float)generator.nextGaussian());
    radius = step*(1.5);
  }
  
  void walk()
  {
    step();
    display();
  }
  
  void display()
  {
    noStroke();
    fill(fill, alpha);
    ellipse(x,y, radius, radius);
    fill(fill, alpha);
  }
  
  void step()
  {
    float stepx = random(-1, 1);
    float stepy = random(-1, 1);
    x += stepx * step;
    y += stepy * step; 
    float distance = dist(x, y, width/2, height/2);
    histogram.add(distance);
  }
  
  void reset()
  {
    x = width/2;
    y = width/2;
  }
}


class Histogram
{
 float[] values;
 int n, nval;
 float min, max;
 float gwidth, gheight, weight=3;
 float sum, t;
 float background;
 boolean h_rescale, v_rescale;
 
 Histogram(int n, float min, float max, float gwidth, float gheight, float bg)
 {
   values = new float[n];
   this.reset();
   this.t = 1;
   this.min = min;
   this.max = max;
   this.gwidth = gwidth;
   this.gheight = gheight;
   this.background = bg;
   if((min == 0) && (max == 0))
   {
     h_rescale = true;
     this.min = 0;
     this.max = 1;
   }
   else {h_rescale = false;}
   if(gheight == 0)
   {
     v_rescale = false;
     gheight = 300;
   }
   else {v_rescale = true;}
 }
 
 void add(float value)
 {
   float growth = (value)/(1);
   sum += (growth);
   nval++;
   if(h_rescale)
   {
     if((value < min) || (max < value))
     {
       rescale(value);
     }
     float index = map(value, min, max, 0, values.length-1);
     values[int(index)]++;
   }
   else if((min < value) && (value < max))
   {
     float index = map(value, min, max, 0, values.length-1);
     values[int(index)]++;
   }
 }
 
 void display()
 {
   // Initialize important values
   float rheight = height-50;
   int l = values.length;
   float w = gwidth/(l);
   //Find maximum value
   float maxval = 0;
   for(float value : values)
   {
     if (value > maxval) {maxval = value;}
   }
   float adjust;
   if (v_rescale)
   {
     adjust = gheight/maxval;
   }
   else
   {
     adjust = weight;
     gheight = maxval*adjust+20;
   }
   fill(background, 6);
   rect(0, rheight-gheight-2, width, gheight+2);
   fill((background+127.5) % 255);
   for (int i=0; i<l; i++)
   {
     // Draw the value
     float h = values[i]*adjust;
     rect(w*i, rheight-h, w-2, h);
   }
   // Display average value of the distribution
   fill(background);
   rect(width-200, 0, 200, 50);
   fill((background+127.5) % 255);
   text(sum/nval, width-200, 20);
   fill(0, 0, 255, 50);
   if(!v_rescale)
   {
     gheight = rheight-height/2;
     stroke(0, 0, 255, 50);
     strokeWeight(1);
     line(0, rheight-gheight, width, rheight-gheight);
     noStroke();
   }
   ellipse(((t*0.2) % width), rheight-gheight-(sum/nval), 3, 3);
   sum = 0; nval = 0; t++;
   this.set();
 }
 
 void set()
 {
   for (int i=0; i<values.length; i++)
    {
      values[i] = 0;
    }
    sum = 0;
    nval = 0;
 }
 
 void reset()
 {
   for (int i=0; i<values.length; i++)
    {
      values[i] = 0;
    }
    sum = 0;
    nval = 0;
    t = 1;
 }
 
 void rescale(float value)
 {
   int l = values.length;
   float[] old_values = new float[l];
   float min_f, max_f;
   arrayCopy(values, old_values);
   // Get the new range
   if (value < min) {min_f=value; max_f=max;}
   else {min_f=min; max_f=value;}
   // Fill the new array with the correponding values
   float w = (max_f-min_f)/l;
   float w0 = (max-min)/l;
   float J0 = (min-min_f)/w;
   int j0 = int(J0);
   for (int j=0; j<j0; j++)
   {
     values[j] = 0;
   }
   float Ij, Ijj;
   int ij, ijj;
   // Fill position J0
   values[j0] = 0;
   Ijj = w/w0; ijj=int(Ijj);
   for(int i=0; i<ijj; i++)
   {
     values[j0] += old_values[i];
   }
   values[j0] += (Ijj-ijj) * old_values[ijj];
   // Fill the other overlapping positions
   float JM = (max-min_f)/w; 
   int jM = int(JM);
   for(int j=j0+1; j<jM; j++)
   {
     values[j] = 0; // Initialize to fill
     Ij = ((j-J0)*w)/w0;
     Ijj = ((j+1-J0)*w)/w0;
     ij = int(Ij); ijj = int(Ijj);
     values[j] += (ij+1-Ij)*old_values[ij];
     for (int i=ij+1; i<ijj; i++)
     {
       values[j] += old_values[i];
     }
     values[j] += (Ijj-ijj) * old_values[ijj];
   }
   // Fill position jM
   values[jM] = 0;
   Ij = ((jM-J0)*w)/w0;
   ij = int(Ij);
   values[jM] += (ij+1-Ij)*old_values[ij];
   for(int i=ij; i<l; i++)
   {
     values[jM] += old_values[i];
   }
   // Fill remaining values
   for(int j=jM+1; j<l; j++)
   {
     values[j] = 0;
   }
   min = min_f;
   max = max_f;
 }
   
}