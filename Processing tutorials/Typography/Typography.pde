void setup()
{
  fullScreen();
  
  textSize(32);
  fill(0);
  text("LAX", 0, 40);
  fill(126);
  text("AMS", 0, 70);
  fill(255);
  text("FRA", 0, 100);
  
  fill(0, 100);
  textSize(64);
  for(int i=0; i<5; i++)
  {
    text('8', 100 + 15*i, 600 + 5*i);
  }
  
  String s = "Five hexing wizards jump quickly";
  textSize(32);
  fill(0);
  text(s, 200, 200, 200, 600);
  
  // Print the available fonts
  String[] fontList = PFont.list();
  printArray(fontList);
  
  PFont noRegrets = createFont("KGNoRegretsSketch.ttf", 100);
  textFont(noRegrets);
  fill(0);
}

void draw()
{
  text("L A X", 500, 300);
  text("L H R", 500, 430);
  text("T X L", 500, 560);
}