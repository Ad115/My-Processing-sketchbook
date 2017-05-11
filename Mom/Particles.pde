class RandomWalker
{
  float x, y;
  float size, speed;
  
  RandomWalker(float size, float min_r, float max_r, float max_speed)
  {
    x = width/2 + random(-1,1)*random(min_r, max_r);
    y = height/2 + random(-1,1)*random(min_r, max_r);
    speed = random(1, max_speed);
    this.size = size;
  }
  
  void walk(color c1, color c2)
  {
    step();
    display(c1, c2);
  }
  
  void display(color c1, color c2)
  {
    noStroke();
    fill(c1);
    ellipse(x,y, size*3, size*3);
    fill(c2);
    ellipse(x, y, size, size);
  }
  
  void step()
  {
    x += speed * random(-1, 1);
    if (x > width || x < 0) {
      x = random(width);
    }
    y += speed * random(-1, 1);
    if (y > height || y < 0) {
      y = random(height);
    }
  }
  
  void reset(float size, float min_r, float max_r, float max_speed)
  {
    x = width/2 + random(-1,1)*random(min_r, max_r);
    y = height/2 + random(-1,1)*random(min_r, max_r);
    speed = random(1, max_speed);
    this.size = size;
  }
}