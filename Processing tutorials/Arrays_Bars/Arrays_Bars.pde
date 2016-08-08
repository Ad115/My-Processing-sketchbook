int[][] x = { {50,0}, {61, 204}, {83,51}, {69, 102}, {71, 0},
            {50, 153}, {29, 0}, {31, 51}, {17, 102}, {39,204} };

void setup()
{
  fullScreen();
}

void draw()
{
  float w = width/x.length;
  for (int i=0; i<x.length; i++)
  {
    fill(x[i][1]);
    rect(0, i*w, x[i][0]*15, w-2);
  }
}