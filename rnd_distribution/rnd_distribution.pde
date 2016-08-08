int n = 200;
int[] distribution;
float w;

void setup()
{
  fullScreen();
  if (n == 0)
  {
    n = width;
  }
  distribution = new int[n];
  for (int i=0; i<distribution.length; i++)
  {
    distribution[i]=0;
  }
  w = width/(n*1.0);
}

void draw()
{
  int rnd = int(random(n));
  distribution[rnd]++;
  fill(150);
  noStroke();
  for (int i=0; i<distribution.length; i++)
  {
    float h = distribution[i];
    rect(w*i, height-h-50, w, h);
  }
}