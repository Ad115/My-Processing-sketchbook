int n = 50;
int[] x = new int[n];
int[] y = new int[n];
int indexPosition=0;

void setup()
{
  fullScreen();
  noStroke();
  fill(255,102);
}

void draw()
{
  background(0);
  x[indexPosition] = mouseX;
  y[indexPosition] = mouseY;
  indexPosition = (indexPosition+1)%n;
  for (int i=0; i<n; i++)
  {
    int pos = (indexPosition+i) % n;
    float radius = (n-i)/2;
    ellipse(x[pos], y[pos], radius, radius);
  }
}