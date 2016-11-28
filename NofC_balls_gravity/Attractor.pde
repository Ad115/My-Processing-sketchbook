class Attractor
{
  float charge;
  PVector position;
  color fillColor;
  
  Attractor(float charge)
  {
    this.position = new PVector(width/2 + random(width/4), height/2 + random(height/4));
    this.charge = charge;
    this.fillColor = color(random(255), random(255), random(255));
  }
  
  PVector position()
  {
    return this.position;
  }
  
  float charge()
  {
    return this.charge;
  }
  
  void draw()
  {
    fill(this.fillColor); 
    ellipse(position.x, position.y, this.size(), this.size());
  }
  
  void attract(Balls balls)
  {
    balls.feelAttractionTo(this);
  }
  
  float size()
  {
    return this.charge/15;
  }
  
}