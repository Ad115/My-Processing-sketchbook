float[] rx, ry;
float[] vx, vy;
float[] fx, fy;
int lx, ly;
int size = 4*10;
int nat = 100;
float sigma = size, eps = 100;
float v0 = 0.1;
int steps = 500;
float dt = 1.0/steps;
int bg;

void setup() {
  fullScreen();
  bg = int(random(255));
  
  lx = width; ly = height;
  
  rx = new float[nat]; ry = new float[nat];
  vx = new float[nat]; vy = new float[nat];
  fx = new float[nat]; fy = new float[nat];
  
  initPositions();
  initVelocities();
}

void draw() {
  move(steps);
  background(bg);
  
  int c1 = (bg+255/4) % 255;
  int c2 = (bg+255/2) % 255;
  noStroke();
  // Draw the shadow
  for (int i=0; i<nat; i++) {
    fill( c1, 100 );
    ellipse(rx[i], ry[i], 2*size, 2*size);
  }
  // Draw the core
  for (int i=0; i<nat; i++) {
    fill( c2 );
    ellipse(rx[i], ry[i], size, size);
  }
}

void initPositions() {
  for (int i=0; i<nat; i++) {
    while(true) {
      rx[i] = random(lx);
      ry[i] = random(ly); 
      
      // check for validity
      boolean valid = true;
      for (int j=0; j<i; j++){
        if ( dist(rx[i], ry[i], rx[j], ry[j]) < sigma) {
          valid = false;
          break;
        }
      }
      if (valid)
        break;
    } 
  }
}

void initVelocities() {
  for (int i=0; i<nat; i++) {
    vx[i] = v0*random(-1, 1);
    vy[i] = v0*random(-1, 1);
  }
}

void move(int steps) {
  // Move
  for (int s=0; s<steps; s++) {
    updateForces();
    updateVelocities();
    
    for(int i=0; i<nat; i++) {
      rx[i] += vx[i]*dt;
      ry[i] += vy[i]*dt;
    }
    thorusBoundary();
  }
}

void thorusBoundary() {
  // rx
  for(int i=0; i<nat; i++) {
    if (rx[i] > lx) {
      rx[i] = 0;
    } else if( rx[i] < 0) {
      rx[i] = lx;
    }
    constrain(rx[i], 0, lx);
  }
  
  
  // ry
  for(int i=0; i<nat; i++) {
    if (ry[i] > ly) {
      ry[i] = 0;
    } else if( ry[i] < 0) {
      ry[i] = ly;
    }
    constrain(rx[i], 0, lx);
  }
}

float distance(int i, int j) {
  return dist(rx[i], ry[i], rx[j], ry[j]);
}

void updateForces() {
  // Calculate forces
  // Init to 0
  for (int i=0; i<nat; i++) {
    fx[i] = 0;
    fy[i] = 0;
  }
  
  // Calculation
  float dx, dy, r, du;
  float cutRadius = 3*sigma;
  for (int i=0; i<nat; i++) {
    for (int j=i-1; j>=0; j--) {
        dx = minDist(rx[i], rx[j], lx);
        dy = minDist(ry[i], ry[j], ly);
        r = sqrt(dx*dx + dy*dy);
        if ( r < cutRadius ) {
          du = 24*eps*pow(sigma/r, 6)*( 2*pow(sigma/r, 6) - 1 )/r;
          fx[i] = fx[i] + du/r*dx;
          fy[i] = fy[i] + du/r*dy;
          fx[j] = fx[j] - du/r*dx;
          fy[j] = fy[j] - du/r*dy;
        }
    }
  }
}

void updateVelocities() {
  float maxV = 20;
  for (int i=0; i<nat; i++) {
    vx[i] += fx[i]/2*dt;
    //constrain(vx[i], -maxV, maxV);
      
    vy[i] += fy[i]/2*dt;
    //constrain(vy[i], -maxV, maxV);
  }
}

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

void keyPressed() {
  if (key=='r') { setup(); }
}