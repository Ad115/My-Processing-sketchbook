float px1, py1, px2, py2;


void setup()
{
  fullScreen();
  strokeWeight(20);
  px1=mouseX; px2=px1;
  py1=mouseY; py2=py1;
}

void draw()
{
  background(204);
  curve(px2, py2, px1, py1, pmouseX, pmouseY, mouseX, mouseY);
  px2=px1; px1=pmouseX;
  py2=py1; py1=pmouseY;
}