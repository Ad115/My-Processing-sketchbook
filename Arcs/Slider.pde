class Slider
{
  float value;
  float min;
  float max;
  int size;

  
  Slider(float min, float max, int size, float initial)
  {
    this.min = min;
    this.max = max;
    this.size = size;
    this.value = initial;
  }
  
  int draw()
  {
    // Update value if necessary
    if (mousePressed) { update(); }
    
    ellipseMode(CORNER);
    noStroke();
    
    // Draw slider bar
    fill(100, 100);
    rect(0, height - size, width, size);
    
    // Draw slider
    float x = map(value, min, max, 0, width) - size/2;
    fill(0, 200);
    ellipse(x, height-size, size, size);
    fill(255, 200); textSize(size);
    text(value, x, height-4);
    
    return int(value);
  }
  
  void update()
  {
    // Check if mouse is over the slider
    if( (height-size < mouseY) && (mouseY < height) )
    {
      // Update the slider value
      value = map(mouseX, 0, width, min, max);
    }
  }
  
  void update(float value)
  {
    this.value = value;
  }
  
}