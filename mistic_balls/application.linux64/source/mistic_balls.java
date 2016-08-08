import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class mistic_balls extends PApplet {

public void setup()
{
  
  noStroke();
}

public void draw()
{
  background(126);
  if(mouseY < height/2)
  {
    fill(255, 150);
    ellipse(mouseX, height/2, mouseY, mouseY);
    fill(0, 150);
    ellipse(width-mouseX, height/2, height-mouseY, height-mouseY);
  }
  else
  {
    fill(0, 150);
    ellipse(width-mouseX, height/2, height-mouseY, height-mouseY);
    fill(255, 150);
    ellipse(mouseX, height/2, mouseY, mouseY);
  }
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "mistic_balls" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
