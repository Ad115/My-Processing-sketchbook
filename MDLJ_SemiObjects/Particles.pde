class LJ_Particles {
  
  // Dinamical variables
  float sigma;
  float epsilon;
  float time_unit;
  float step_resolution;
  
  // Box/enviroment variables
  float lx, ly; // Dimensions of the box
  int n; // Number of particles
  
  // Graphics variables
  float size;
  float bg_color;
  
  // Particles...
  PVector[] p; // Positions
  PVector[] v; // Velocities
  PVector[] f; // Forces
  float[] previous_v;
  float[] dK; // Changes in kinetic energy 
  
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
    dK = new float[n];
    previous_v = new float[n];
    for(int i=0; i<n; i++){
      p[i] = new PVector(0,0);
      v[i] = new PVector(0,0);
      f[i] = new PVector(0,0);
      dK[i] = 0;
      previous_v[i] = 0;
    }
      
    initPositions(min_dist, lx, ly);
    initVelocities(max_vel);
  }
  
  void initPositions(float min_distance, float lx, float ly) {
    randomPositions(min_distance, lx, ly);
  }
  
  void randomPositions(float min_distance, float lx, float ly) {
    // Validate dimensions (particles musn't overlap)
    float alpha = (lx*ly) / (n*(sigma*sigma));
    if (alpha <= 1) { // If area of molecules is bigger than the area of the box
        lx = lx * (1/(alpha*alpha)) * (1+0.5);
        ly = ly * (1/(alpha*alpha)) * (1+0.5);
    }
    
    for (int i=0; i<n; i++) {
      // Calculate the position of the ith particle
      while(true) {
        float px_i = ( this.lx + lx*random(-1, 1) )/2;
        float py_i = ( this.ly + ly*random(-1, 1) )/2;
        
        // Check for validity
        boolean valid = true;
        for (int j=0; j<i; j++) {
          // Check if the jth particle doesn't overlap
          float px_j = p[j].x;
          float py_j = p[j].y;
          float dx = minDist(px_i, px_j, lx);
          float dy = minDist(py_i, py_j, ly);
          float r = sqrt(dx*dx + dy*dy);
          if ( r < min_distance ) {
            // Not valid
            valid = false;
            break;
          }
        }
        if (valid) {
          // Valid position, store it and continue
          p[i].set(px_i, py_i);
          break;
        }
      } 
    }
  }
  
  void initVelocities(float max_vel) {
    for (int i=0; i<n; i++) {
      v[i].set(lx/2-p[i].x, ly/2-p[i].y);
      //v[i] = PVector.random2D(v[i]);
      v[i].setMag( random(max_vel) );
    }
  }
  
  //******* Dynamics **********//
  
  void update(int mode, float time_unit) {
    float dt = time_unit/step_resolution;
    for(int i=0; i<n; i++) {
      previous_v[i] = v[i].magSq();
      for (int s=0; s<step_resolution; s++) {
        updateForces();
        updateVelocities(dt);
        updatePositions(dt, lx, ly);
      }
      energyTransfers(mode);
    }
  }
  
  void updateForces() {    
    float dx, dy, r, du;
    float cutRadius = 3*sigma;
    
    // Initialize in zeroes
    for(int i=0; i<n; i++) {
      f[i].set(0,0);
    }
    
    for (int i=0; i<n; i++) {
      for (int j=i-1; j>=0; j--) {
        dx = minDist(p[i].x, p[j].x, lx);
        dy = minDist(p[i].y, p[j].y, ly);
        r = sqrt(dx*dx + dy*dy);
        if ( r < cutRadius ) {
          du = 24*epsilon*pow(sigma/r, 6)*( 2*pow(sigma/r, 6) - 1 )/r;
          f[i].add(du/r * dx, du/r * dy);
          f[j].sub(du/r * dx, du/r * dy);
        }
      }
    }
  }
  
  void updateVelocities(float dt) {
    for(int i=0; i<n; i++) {
      v[i].add(f[i].x/2*dt, f[i].y/2*dt);
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
  
  void energyTransfers(int mode) {
    if ((mode % 3) == 2) {
      float force;
      for(int i=0; i<n; i++) {
        force = f[i].mag(); 
        dK[i] = force-0.5*(force-dK[i]);
      }
    } else if ((mode % 3) == 1) {
      float previous_K, current_K, K_diff, prev_K_diff;
      for(int i=0; i<n; i++) {
        previous_K = previous_v[i];
        current_K =  v[i].magSq();
        K_diff = current_K - previous_K;
        prev_K_diff = dK[i];
        dK[i] = K_diff - 0.995*(K_diff-prev_K_diff);
      }
    }
  }
  
  //******* Drawing **********//
  
  void draw(int mode, float color_intensity) {
    //background(bg_color);
    switch (mode % 3) {
      case 0:
        drawSimple();
        break;
      case 1:
        drawEnergyExchange(5*color_intensity);
        break;
      case 2:
        drawEnergyConservation(color_intensity);
    }
  }
  
  void drawSimple() {
    int bg = int(bg_color);
    int c1 = (bg+255/4) % 255;
    int c2 = (bg+255/2) % 255;
    noStroke();
    
    // Draw transparent background
    fill(bg, 5);
    rect(0,0,width, height);
    fill(c2, 1);
    rect(0,0,width, height);
    
    // Draw the shadow
    float rx, ry;
    fill( c1, 150);
    for (int i=0; i<n; i++) {
      rx = p[i].x;
      ry = p[i].y;
      ellipse(rx, ry, 2*size, 2*size);
    }
    
    // Draw the core
    fill(c2);
    for (int i=0; i<n; i++) {
      rx = p[i].x;
      ry = p[i].y;      
      ellipse(rx, ry, size, size);
    }
  }
  
  void drawEnergyConservation(float color_intensity) {
    int bg = int(bg_color);
    int c1 = (bg+255/4) % 255;
    int c2 = (bg+255/2) % 255;
    noStroke();
    
    // Draw transparent background
    fill(bg, 5);
    rect(0,0,width, height);
    fill(c2, 1);
    rect(0,0,width, height);
    
    // Draw the shadow
    float rx, ry, f_i, h;
    for (int i=0; i<n; i++) {
      rx = p[i].x;
      ry = p[i].y;
      f_i = color_intensity*dK[i]; 
      fill( 2*f_i+c1/2, f_i/6+c1/2, 0+c1/2, 150);
      
      ellipse(rx, ry, 2*size+f_i/120, 2*size+f_i/120);
    }
    
    // Draw the core
    for (int i=0; i<n; i++) {
      rx = p[i].x;
      ry = p[i].y;
      h = color_intensity*v[i].magSq();
      //if (h>0) {
      // fill( 0+c2, 0+c2, h+c2);
      //} else {
      //  fill( 4*abs(h)+c2, abs(h)/3+c2, 0+c2);
      //} 
      fill(0+c2/2, 10*sqrt(h)/6+c2/2, h+c2/2);
      
      ellipse(rx, ry, size, size);
    }
  }
  
  void drawEnergyExchange(float color_intensity) {
    int bg = int(bg_color);
    int c1 = (bg+255/4) % 255;
    int c2 = (bg+255/2) % 255;
    noStroke();
    
    // Draw transparent background
    fill(bg, 5);
    rect(0,0,width, height);
    fill(c2, 1);
    rect(0,0,width, height);
    
    // Draw the shadow
    float rx, ry, h;
    for (int i=0; i<n; i++) {
      rx = p[i].x;
      ry = p[i].y;
      h = color_intensity*dK[i];
      if (h>0) {
        fill( 0+c1/2, 0+c1/2, h/2+c1/2, 100);
      } else {
        fill( 2*abs(h)+c1/2, abs(h)/6+c1/2, 0+c1/2, 100 );
      }
      
      ellipse(rx, ry, 2*size, 2*size);
    }
    
    // Draw the core
    for (int i=0; i<n; i++) {
      rx = p[i].x;
      ry = p[i].y;
      h = color_intensity*dK[i];
      if (h>0) {
       fill( 0+c2, 0+c2, h+c2);
      } else {
        fill( 4*abs(h)+c2, abs(h)/3+c2, 0+c2);
      } 
      
      ellipse(rx, ry, size, size);
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
}