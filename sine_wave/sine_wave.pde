float[] angles;

void setup()
{
  fullScreen();
  angles = new float[width];
  for(int i = 0; i<width; i++)
  {
    float r = map(i, 0, width, 0, 2*TWO_PI);
    angles[i] = r;
  }
}

void draw()
{
  for (int i=0; i<width; i++)
  {
    stroke(127.5*(sin(angles[i])+1));
    line(i, 0, i, height);
    angles[i]-=0.2;
  }
}