LJ_Particles particles;
int lx, ly;
int size = 1*10;
int n = 30;
float sigma = size; 
float epsilon = 10;
int steps_per_frame = 100;
float v0 = 1;
int bg_color;

void setup() {
  fullScreen();
  bg_color = int(random(255));
  
  lx = width; ly = height;
  
  particles = new LJ_Particles();
  particles.setDynamics(sigma, epsilon, steps_per_frame);
  particles.setSystem(n, width, height);
  particles.setGraphics(bg_color, size);
  particles.init(sigma, v0);
}

void draw() {
  particles.update();
  particles.draw();
}

void keyPressed() {
  if (key=='r') { setup(); }
}