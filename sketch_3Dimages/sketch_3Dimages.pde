PImage img;       // The source image
int cellsize = 2; // Dimensions of each cell in the grid
int depth = 5;
int cols, rows;   // Number of columns and rows in our system
float w, h;

void setup() {
 fullScreen(P3D);
  img  = loadImage("bryan.jpg"); // Load the image
  cols = width/cellsize;             // Calculate # of columns
  rows = height/cellsize;            // Calculate # of rows
  w = ((float)img.width) / ((float)cols);
  h = ((float)img.height) / ((float)rows);
}

void draw() {
  background(0);
  loadPixels();
  float x, y, x_img, y_img;
  int img_index;
  // Begin loop for rows
  for ( int i = 0; i < rows;i++) {
    // Begin loop for columns
    for ( int j = 0; j < cols;j++) {
      x_img = j * w + w/2;
      y_img = i * h + h/2;
      img_index = int(x_img) + int(y_img)*img.width;
      color c = color(0);
      if (img_index < img.pixels.length)
      {
        c = img.pixels[img_index];       // Grab the color
      }
      // Translate to the location, set fill and stroke, and draw the rect
      pushMatrix();
      x = j*cellsize + cellsize/2.0; // x position
      y = i*cellsize + cellsize/2.0; // y position
      // Calculate a z position as a function of mouseX and pixel brightness
      float z = depth * (mouseX/(float)width) * brightness(c)-20;
      translate(x,y - (mouseY-height/2),z);
      fill(c);
      noStroke();
      rectMode(CENTER);
      rect(0,0,cellsize,cellsize);
      popMatrix();
    }
  }
}