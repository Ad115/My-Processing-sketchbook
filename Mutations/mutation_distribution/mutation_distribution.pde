int bg;
int size = 10;
Distribution distribution = new Distribution(1000);
int[] freqDist;

void setup(){
  fullScreen();
  bg = int(random(255));
  background(bg);
  
  
}

void draw() {
  background(bg);
  distribution.experiment(int( 500*noise(0.01*frameCount) ));
  assembleFreqDistribution(mutations, freqDist);
  drawDistribution(mutations, 200, 0, 0, 255);
  drawDistribution(freqDist, 0, 0, 200, 100);
}

int ccolor(int c) {
  return (c + 255/2) % 255;
}