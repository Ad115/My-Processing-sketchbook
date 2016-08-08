size(200, 600);
background(0);
noStroke();

// No fourth argument means 100% opacity
fill(0, 0, 255);
rect(0, 0, width/2, height);

// 255 also means 100% opacity
fill(255, 0, 0, 255);
rect(0, 0, width, height/5);

// 75% opacity
fill(255, 0, 0, 191);
rect(0, height/4, width, height/5);

// 55% opacity
fill(255, 0, 0, 127);
rect(0, height/2, width, height/5);

// 25% opacity
fill(255, 0, 0, 63);
rect(0, 3.0/4*height, width, height/5);