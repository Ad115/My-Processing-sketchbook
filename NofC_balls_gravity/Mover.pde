class BouncingBall
{
  PVector position;
  PVector velocity;
  PVector acceleration;
  float size;
  float mass;
  color fillColor;
  boolean in_liquid = false;
  
  BouncingBall()
  {
    this.size = random(50);
    this.mass = this.size*5;
    this.position = new PVector(random(size/2, width-size/2), random(size/2, height-size/2));
    this.velocity = new PVector(0, 0);//PVector.random2D().setMag(random(3));
    this.acceleration = new PVector(0, 0);
    this.fillColor = color(random(255));
  }
  
  void applyForce(PVector force)
  {
    PVector effect = PVector.div(force, mass);
    acceleration.add(effect);
  }
  
  void update()
  {
    // Towards the mouse
    PVector mouse = new PVector(mouseX, mouseY);
    PVector mouse_force = PVector.sub(mouse, position);
    mouse_force.setMag(7);
    if (mousePressed)
      { mouse_force.setMag(50); }
    // Wind force
    PVector wind_force = new PVector(-noise(0.05*(frameCount+size)), 0);
    // Gravity
    PVector gravity_force = new PVector(0, 0.07*mass); 
    
    // Apply forces and move
    acceleration.setMag(0);
    this.applyForce(mouse_force);
    this.applyForce(wind_force);
    this.applyForce(gravity_force);
    
    this.move();
  }
  
  void move()
  {
    velocity.add(acceleration);
    position.add(velocity);
    bounce();
    //wrapAround();
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
    stroke(0);
    ellipseMode(CENTER);
    fill(this.fillColor);
    if (this.in_liquid)
      { fill(255, 0, 0); }
    ellipse(position.x, position.y, size, size);
  }
  
  void randomize(float r)
  {
    velocity = PVector.random2D();
    //velocity.setMag(0.25);
    //size = random(200);
  }
  
  boolean isInside(Liquid liquid)
  {
    // Test horizontal axis
    boolean is_inside = (liquid.position.x < this.position.x) &&
                        (liquid.position.x + liquid.size.x > this.position.x);
     
    // Test vertical axis
    is_inside = is_inside &&
                (liquid.position.y < this.position.y) &&
                (liquid.position.y + liquid.size.y > this.position.y);
                
    this.in_liquid = is_inside;
    
    return is_inside;
  }
  
  void feelDrag(Liquid liquid)
  {
    if(this.isInside(liquid))
    {
      float speed = velocity.mag();
      float drag = this.size * speed * speed * liquid.viscosity;
      PVector dragForce = PVector.mult(velocity,-1);
      dragForce.setMag(drag);
      
      acceleration.set(0,0);
      this.applyForce(dragForce);
      velocity.add(acceleration);
      //velocity.limit(speed);
      velocity.limit(2*this.mass/(liquid.viscosity*this.size));
      position.add(velocity);
    }
  }
  
  void feelAttractionTo(Attractor attractor)
  {
    PVector attraction = attractionTo(attractor);
    acceleration.set(0,0);
    this.applyForce(attraction);
    velocity.add(acceleration);
    position.add(velocity);
  }
    
  PVector attractionTo(Attractor a)
  {
    PVector separation = (PVector.sub(a.position(), this.position));
    float distance = separation.mag();
    constrain(distance, 5, a.size()*100);
    PVector attraction = separation;
    attraction.setMag(this.mass * a.charge() / (distance*distance));
    attraction.limit(100);
    return attraction;
  }
}