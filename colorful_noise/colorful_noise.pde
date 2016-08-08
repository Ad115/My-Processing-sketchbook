int t;

void setup()
{
  fullScreen();
  frameRate(60);
  t = 1;
}

void draw()
{
    loadPixels();
    for (int x=0; x<width; x++)
    {
      for (int y=0; y<height; y++)
      {
        int index = x + y*width;
        float r = 0.01;
        float rt = 0.1;
        color c = color(255*noise(x*r, y*r + 10000, rt*t), 255*noise(x*r, y*r + 10000, rt*t+ 1000), 255*noise(x*r, y*r + 10000, rt*t+2000));
        pixels[index] = c;
      }
    }
    updatePixels();
    t++;
}