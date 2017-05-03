int bg;
int size = 10;
int[] mutations = new int[1000];

void setup(){
  fullScreen();
  bg = int(random(255));
  background(bg);
}

void draw() {
  background(bg);
  update();
  int[] dist = assembleFreqDistribution(mutations);
  drawDistribution(dist);
}

void update(){
  mutations[ int(random(mutations.length)) ]++;
}

void drawDistribution(int[] mutations) {
  fill( (bg+255/2) % 255 );
  int n = mutations.length;
  int w = width/n;
  for (int i=0; i<n; i++){
    rect(i*w, height*0.8-mutations[i], w, mutations[i]);
  }
}

int[] assembleFreqDistribution(int [] mutations) {
  int n = width/size;
  int[] distribution = new int[n];
  for(int value : mutations) {
    if (value < n)
      distribution[value]++;
  }
  return distribution;
}