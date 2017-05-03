float size = 10;
float bg;
float[] previous = new float[4];
int t;
float rate = 5;
boolean loop = true;

void setup()
{
  fullScreen();
  bg = random(255);
  background(bg);
  stroke((bg+127.5) % 255);
  fill((bg+64) % 255);
  t = 3;
  for(int i=0; i<previous.length; i++)
  {
    previous[i] = height/2;
  }
}

void draw()
{
  float now =  height*noise(t*0.05); //random(height); //
  int l = previous.length;
  previous[t % l] = now;
  strokeWeight(random(size));
  float x = (t*rate) % width;
  curve(x - 3*rate, previous[(t-3) % l], 
        x - 2*rate, previous[(t-2) % l],
        x - rate, previous[(t-1) % l],
        x, previous[t % l]);
  if(x >= width - rate)
  {
    bg = random(255);
  
    fill(bg, 50);
    rect(-5,-5, width, height);
    fill((bg+64) % 255);
    stroke((bg+127.5) % 255);
  }
  t++;
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
}