class LJ_Particles {
  
  // Dinamical variables
  float sigma;
  float epsilon;
  float steps_per_frame;
  float dt;
  
  // Box/enviroment variables
  float lx, ly; // Dimensions of the box
  int n; // Number of particles
  
  // Graphics variables
  float size;
  float bg_color;
  
  // Particles...
  Particle[] particles;
  
  //******* Initialization **********//
  
  void setDynamics(float sigma, float epsilon, float steps_per_frame) {
    this.sigma = sigma;
    this.epsilon = epsilon;
    this.steps_per_frame = steps_per_frame;
    this.dt = 1 / steps_per_frame;
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
  
  void init(float min_dist, float max_vel) {
    particles = new Particle[n];
    for (int i=0; i<n; i++)
      particles[i] = new Particle();
      
    initPositions(min_dist);
    initVelocities(max_vel);
  }
  
  void initPositions(float min_distance) {
    for (int i=0; i<n; i++) {
      // Calculate the position of the ith particle
      while(true) {
        float px_i = random(lx);
        float py_i = random(ly);
        
        // Check for validity
        boolean valid = true;
        for (int j=0; j<i; j++) {
          // Check if the jth particle doesn't overlap
          float px_j = particles[j].p.x;
          float py_j = particles[j].p.y;
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
          particles[i].setPosition(new PVector(px_i, py_i));
          break;
        }
      } 
    }
  }
  
  void initVelocities(float max_vel) {
    for (int i=0; i<n; i++) {
      float vx = max_vel*random(-1, 1);
      float vy = max_vel*random(-1, 1);
      particles[i].setVelocity(new PVector(vx, vy));
    }
  }
  
  //******* Dynamics **********//
  
  void update() {
    for(int i=0; i<n; i++) {
      for (int s=0; s<steps_per_frame; s++) {
        updateForces();
        particles[i].update(dt, lx, ly);
      }
    }
  }
  
  void updateForces() {    
    float dx, dy, r, du;
    float cutRadius = 3*sigma;
    
    // Initialize in zeroes
    for(int i=0; i<n; i++) {
      particles[i].f.set(0,0);
    }
    
    for (int i=0; i<n; i++) {
      for (int j=i-1; j>=0; j--) {
        dx = minDist(particles[i].p.x, particles[j].p.x, lx);
        dy = minDist(particles[i].p.y, particles[j].p.y, ly);
        r = sqrt(dx*dx + dy*dy);
        if ( r < cutRadius ) {
          du = 24*epsilon*pow(sigma/r, 6)*( 2*pow(sigma/r, 6) - 1 )/r;
          particles[i].f.add(du/r * dx, du/r * dy);
          particles[j].f.sub(du/r * dx, du/r * dy);
        }
      }
    }
  }
  
  //******* Drawing **********//
  
  void draw() {
    background(bg_color);
    
    int bg = int(bg_color);
    int c1 = (bg+255/4) % 255;
    int c2 = (bg+255/2) % 255;
    noStroke();
    
    
    float rx, ry;
    for (int i=0; i<n; i++) {
      rx = particles[i].p.x;
      ry = particles[i].p.y;
      // Draw the shadow
      fill( c1, 100 );
      ellipse(rx, ry, 2*size, 2*size);
      // Draw the core
      fill( c2 );
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
}