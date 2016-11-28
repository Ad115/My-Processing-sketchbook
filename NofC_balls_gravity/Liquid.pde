class Liquid
{
  PVector position;
  PVector size;
  float viscosity;
 
  Liquid(float x, float y, float w, float h, float v)
  {
    position = new PVector(x, y);
    size = new PVector(w, h);
    viscosity = v;
  }
  
  void draw()
  {
    noStroke();
    fill(20, 150);
    rect(position.x, position.y, size.x, size.y);
  }
  
  void drag(Balls balls)
  {
    balls.feelDrag(this);
  }
}