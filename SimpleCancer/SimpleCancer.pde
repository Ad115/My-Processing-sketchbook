CancerCells_LJ cells;
float size = 2*10;
int n = 100;
float sigma = size; 
float epsilon = 0.0001;
float time_unit = 0.05; // Frames per unit time
float step_resolution = 10; // Each frame has this steps
float packing = 0.2;
float color_intensity = 1;
float v0 = 0;
int bg_color;
int mode = 0;

void setup() {
  fullScreen();
  bg_color = int(random(255));
  background(bg_color % 255);
  
  int lx, ly;
  lx = width; ly = height;
  
  cells = new CancerCells_LJ();
  cells.setDynamics(sigma, epsilon, time_unit, step_resolution);
  cells.setSystem(n, width, height);
  cells.setGraphics(bg_color, size);
  cells.init(sigma, v0, lx*packing, ly*packing);
}

void draw() {
  cells.update(mode);
  cells.draw(mode, color_intensity);
}

void keyPressed() {
  if (key == 'r') { setup(); }
  if (key == 'c') { mode++; }
}