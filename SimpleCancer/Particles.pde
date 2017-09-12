class CancerCells_LJ {
  
  // Dinamical variables
  float sigma;
  float epsilon;
  float time_unit;
  float step_resolution;
  float division_time=100;
  
  // Box/enviroment variables
  float lx, ly; // Dimensions of the box
  int n; // Number of particles
  
  // Graphics variables
  float size;
  float bg_color;
  
  // Particles...
  float[] last_div;
  float[] parent;
  float[] alive;
  PVector[] p; // Positions
  PVector[] v; // Velocities
  PVector[] f; // Forces
  
  //******* Initialization **********//
  
  void setDynamics(float sigma, float epsilon, float time_unit, float step_resolution) {
    this.sigma = sigma;
    this.epsilon = epsilon;
    this.time_unit = time_unit;
    this.step_resolution = step_resolution;
  }
  
  void setSystem(int n, float lx, float ly) {
    this.n = n;
    this.lx = lx;
    this.ly = ly;
  }
  
  void setGraphics(float bg_color, float particle_size) {
    this.bg_color = bg_color;
    this.size = particle_size;
  }
  
  void init(float min_dist, float max_vel, float lx, float ly) {
    p = new PVector[n];
    v = new PVector[n];
    f = new PVector[n];
    last_div = new float[n];
    parent = new float[n];
    alive = new float[n];
    for(int i=0; i<n; i++){
      p[i] = new PVector(0,0);
      v[i] = new PVector(0,0);
      f[i] = new PVector(0,0);
      last_div[i] = 0;
      alive[i] = 0;
      parent[i] = -1;
    }
      
    initCells(min_dist, lx, ly);
    initVelocities(max_vel);
  }
  
  void initCells(float min_distance, float lx, float ly) {
    alive[0] = 1;
    p[0].set(this.lx/2, this.ly/2);
    last_div[0] = division_time*0.7;
  }
  
  void initVelocities(float max_vel) {
    // Nada....
  }
  
  //******* Dynamics **********//
  
  void update(int mode) {
    float dt = time_unit/step_resolution;
    for(int i=0; i<n; i++) {
      for (int s=0; s<step_resolution; s++) {
        updateForces();
        updateVelocities(dt);
        updatePositions(dt, lx, ly);
      }
    }
    divide();
  }
  
  void updateForces() {    
    float dx, dy, r, du;
    float cutRadius = 3*sigma;
    
    // Initialize in zeroes
    for(int i=0; i<n; i++) {
      f[i].set(0,0);
    }
    
    for (int i=0; i<n; i++) {
      if (alive[i]>0) {
        for (int j=i-1; j>=0; j--) {
          if (alive[j]>0) {
            dx = minDist(p[i].x, p[j].x, lx);
            dy = minDist(p[i].y, p[j].y, ly);
            r = sqrt(dx*dx + dy*dy);
            if ( r < cutRadius ) {
              if (r < sigma) {
                du = pow(alive[i]*alive[j], 12)*24*epsilon*pow(sigma/r, 6)*( 2*pow(sigma/r, 6) - 1 )/r;
                f[i].add(du/r * dx, du/r * dy);
                f[j].sub(du/r * dx, du/r * dy);
              } else {
                du = pow(alive[i]*alive[j], 12)*24*epsilon*pow(sigma/r, 6)*( 2*pow(sigma/r, 6) - 1 )/r;
                constrain(du, -10000, 10000);
                f[i].add(du/r * dx, du/r * dy);
                f[j].sub(du/r * dx, du/r * dy);
              }
            }
          }
        }
      }
    }
  }
  
  void updateVelocities(float dt) {
    for(int i=0; i<n; i++) {
      v[i].add(f[i].x/2*dt, f[i].y/2*dt);
      PVector.mult(v[i], 0.0000001);
    }
  }
  
  void updatePositions(float dt, float lx, float ly) {
    for(int i=0; i<n; i++) {
      //p[i].add(v[i].x*dt, v[i].y*dt);
      p[i].x = thorusBoundary(p[i].x + v[i].x*dt, lx);
      p[i].y = thorusBoundary(p[i].y + v[i].y*dt, ly);
    }
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
  
  void divide() {
    float divide;

    for (int i=0; i<n; i++) {
      if (alive[i]>0) {
        if (alive[i] == 1) {
          last_div[i] += random(1);
          divide = 1-(division_time-last_div[i])/division_time;
          divide = divide*random(1)*random(1);
          if (divide > 0.99) {
            last_div[i]=0;
            println("Cell " + i + " is dividing, divide = " + divide);
            // Find a dead cell
            int j = findDead();
            if (j>=0) {
              // Be born
              alive[j] = 1/division_time;
              PVector.random2D(p[j]);
              p[j].setMag(sigma*random(1.1,1.2));
              p[j].add(p[i]);
              parent[j] = i;
            }
          }
        } //if (alive[i] == 1)
          else {
            last_div[int(parent[i])] = 0;
            alive[i] += 1/division_time;
            if (alive[i] > 1) {
              alive[i] = 1;
              last_div[i] = 0;
           }
         }
       } // if (alive[i]>0)
     } //for (int i=0; i<n; i++)
  }
     
     float newChildPosition(float x, float off) {
       float r = random(-1,1);
       r = r/abs(r);
       return x + r*sigma + random(-off*sigma, off*sigma);
     }
  
  //******* Drawing **********//
  
  void draw(int mode, float color_intensity) {
    drawSimple();
  }
  
  void drawSimple() {
    int bg = int(bg_color);
    int c1 = (bg+255/4) % 255;
    int c2 = (bg+255/2) % 255;
    noStroke();
    
    //background(bg);
    // Draw transparent background
    fill(bg, 5);
    rect(0,0,width, height);
    fill(c2, 1);
    rect(0,0,width, height);
    
    // Draw the shadow
    float rx, ry, h;
    fill( c1, 150);
    for (int i=0; i<n; i++) {
      if (alive[i]>0) {
        rx = p[i].x;
        ry = p[i].y;
        ellipse(rx, ry, 2*alive[i]*size, 2*alive[i]*size);
      }
    }
    
    // Draw the core
    fill(c2);
    stroke(255);
    for (int i=0; i<n; i++) {
      if (alive[i]>0) {
        rx = p[i].x;
        ry = p[i].y; 
        ellipse(rx, ry, alive[i]*size, alive[i]*size);
      }
    }
  }
  
  //******* Other **********//
  
  float minDist(float p1, float p2, float l) {
    float dr = p1-p2;
    if (dr <= -l/2) {
      return (p1 + l-p2);
    } else if ( dr <= l/2 ){
      return dr;
    } else {
      return -(p2 + l-p1);
    }
  }
  
  boolean equalSigns(float a, float b) {
    if (a*b == 0) {
      return true;
    }
    return (a/b > 0) ? (true) : (false);
  }
  
  int findDead() {
    for (int i=0; i<n; i++) {
      if (alive[i] == 0) {
        return i;
      }
    }
    return -1;
  }
}