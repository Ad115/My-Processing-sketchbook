LJ_Particles particles;
float size = 10;
int n = 70;
float sigma = size; 
float epsilon = 100000;
float time_unit = 0.0005; // Frames per unit time
float step_resolution = 10; // Each frame has this steps
float packing = 1;
float color_intensity = 0.009;
float v0 = 100;
int bg_color;
int mode = 0;
boolean paused = false;
boolean paint_background = false;

void setup() {
  fullScreen(P2D);
  bg_color = int(random(255));
  background(bg_color % 255);
  
  int lx, ly;
  lx = width; ly = height;
  
  particles = new LJ_Particles();
  particles.setDynamics(sigma, epsilon, time_unit, step_resolution);
  particles.setSystem(n, width, height);
  particles.setGraphics(bg_color, size);
  particles.init(sigma, v0, lx*packing, ly*packing);
}

void draw() {
  if (!paused) {
    if (paint_background) { background(bg_color); }
    particles.update(mode, time_unit);
    particles.draw(mode, color_intensity);
  }
}

void keyPressed() {
  if (key == 'r') { setup(); }
  if (key == 'c') { mode++; }
  if (key == 'p') { paused = !paused; }
  if (key == '+') { time_unit *= 1.5; }
  if (key == '-') { time_unit /= 1.5; }
  if (key == 'b') { paint_background = !paint_background; }
  
}