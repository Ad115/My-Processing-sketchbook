class Particle {
  PVector p;
  PVector v;
  PVector f;
  
  Particle() {
    p = new PVector();
    v = new PVector();
    f = new PVector();
  }
  
  //******* Getters / Setters **********//
  
  // Position getter/setter
  void setPosition(PVector p) {
    this.p = p.copy();
  }
  
  PVector getPosition() {
    return p;
  }
  
  // Velocity getter/setter
  void setVelocity(PVector v) {
    this.v = v.copy();
  }
  
  PVector getVelocity() {
    return v;
  }
  
  // Force getter/setter
  void setForce(PVector f) {
    this.f = f.copy();
  }
  
  PVector getForce() {
    return f;
  }
  
  //******* Dynamics **********//
  
  void update(float dt, float lx, float ly) {
    updateVelocity(dt);
    updatePosition(dt, lx, ly);
  }
  
  void updatePosition(float dt, float lx, float ly) {
    p.x = thorusBoundary(p.x + v.x*dt, lx);
    p.y = thorusBoundary(p.y + v.y*dt, ly);
  }
  
  void updateVelocity(float dt) {
    v.x += f.x/2 * dt;
    v.y += f.y/2 * dt;
  }
  
  float thorusBoundary(float x, float l) {
    if (x > l) {
      x -= l;
    } else if(x < 0) {
      x += l;
    }
    constrain(x, 0, l);
    return x;
  }
}