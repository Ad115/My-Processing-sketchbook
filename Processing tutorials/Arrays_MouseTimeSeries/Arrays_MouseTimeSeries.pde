int[] y;

void setup()
{
  fullScreen();
  y = new int[width];
  for(int i=0; i<y.length; i++)
  {
    y[i] = height/2;
  }
}

void draw()
{
  background(204);
  for (int i=y.length-1; i>0; i--)
  {
    y[i] = y[i-1];
  }
  y[0] = mouseY;
  for (int i=1; i<y.length; i++)
  {
    line(width-i, y[i], width-(i-1), y[i-1]);
  }
}