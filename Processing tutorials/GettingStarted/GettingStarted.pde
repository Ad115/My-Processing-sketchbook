void setup() {
  size(960, 240);
}

void draw() {
  // Set filling color
  if (mousePressed)
    fill(0);
  else
    fill(255);
  
  // Draw the ellipse
  ellipse(mouseX, mouseY, 80, 80);
}