class BouncingBall
{
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector force;
  float size;
  
  BouncingBall()
  {
    this.size = random(200);
    this.position = new PVector(random(size/2, width-size/2), random(size/2, height-size/2));
    this.velocity = new PVector(0, 0);
    this.acceleration = new PVector(0, 0);
    this.force = new PVector(0, 0);
  }
  
  void update()
  {
    PVector mouse = new PVector(mouseX, mouseY);
    force = PVector.sub(mouse, position);
    force.setMag(10);
    
    float mass = size;
    acceleration = PVector.div(force, mass) ;
    velocity.limit(7);
  }
  
  void move()
  {
    velocity.add(acceleration);
    position.add(velocity);
    //bounce();
  }
  
  void bounce()
  {
    if( position.x < 0 + size/2 ) 
      { position.x=0+size/2; velocity.x = -velocity.x; }
    if( position.x > width - size/2 ) 
      { position.x=width-size/2; velocity.x = -velocity.x; }
    
    if( position.y < 0 + size/2 ) 
      { position.y=0+size/2; velocity.y = -velocity.y; }
    if( position.y > height - size/2 ) 
      { position.y=height-size/2; velocity.y = -velocity.y; }
  }
  
  void wrapAround()
  {
    if( position.x + size/2 < 0 ) 
      { position.x=width+size/2; }
    if( position.x > width + size/2 ) 
      { position.x=-size/2; }
    
    if( position.y + size/2 < 0 ) 
      { position.y=height+size/2; }
    if( position.y > height + size/2 ) 
      { position.y=-size/2; }
  }
  
  void draw()
  {
    ellipseMode(CENTER);
    fill(255*noise(0.05*frameCount + size));
    ellipse(position.x, position.y, size, size);
  }
  
  void randomize(float r)
  {
    //velocity.x = random(-r, r);
    //velocity.y = random(-r, r);
    velocity = PVector.random2D();
    //velocity.setMag(0.25);
    //size = random(200);
  }
}