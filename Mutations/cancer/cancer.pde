//INCOMPLETE

CellularAutomaton life;
float cellSize = 2;
float seedProbability = 0.5;
float noiseRate = 0.09;
boolean loop;
color 

//******************************************************************

void setup()
{ fullScreen();
  life = new CellularAutomaton(cellSize, seedProbability);
  life.draw();
  loop = true;
}

//******************************************************************

void draw()
{ life.step(); //<>//
  life.draw();
  displayFrameRate();
}

//******************************************************************

void keyPressed()
{ if (key == 'r' || key == 'R')
  { life.reset();
    life.draw();
  }
  
  if (key == 'p' || key == 'P')
  { if (loop)
    { noLoop();
      loop = false;
    }
    else
    { loop();
      loop = true;
    }
  }
}

//******************************************************************

void displayFrameRate()
{
  String text = "Framerate: " + frameRate;
  fill(200);
  textSize(24);
  rectMode(CORNER);
  rect(0, 0, textWidth(text)+10, 30);
  fill(0);
  text(text, 10, 24);
}

//******************************************************************
  
boolean event(float probability)
{ boolean success = false;
  if (random(1) < probability)  {  success = true; }
  return success;
}
  
  
  