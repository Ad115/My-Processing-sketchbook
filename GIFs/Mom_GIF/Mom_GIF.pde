Hearts hearts;
RandomWalker[] particles = new RandomWalker[100];
int n = 10;
int size = 7;
float beatRate = 0.05;
float phase = 1.5;
color bg1, bg2;
color fill1, fill2;
color pc1, pc2;
PFont font;

// GIF>=======================
import gifAnimation.*;

GifMaker gifExport;
int frames = 0;
int totalFrames = int(TAU/beatRate);
// GIF<========================


void setup() {
  // GIF>=======================
  smooth();
  size(600, 600);

  gifExport = new GifMaker(this, "Mom.gif", 100);
  gifExport.setRepeat(0); // make it an "endless" animation
  // GIF<========================
  
  colorMode(RGB);
  bg1 = color(#0e4675);
  bg2 = color(#540101);
  fill1 = color(#f9545b);
  fill2 = color(#f9d4db);
  pc1 = color(#ff9690, 50);
  pc2 = color(#ff96a0);
  
  hearts = new Hearts(n, fill1, fill2);
  
  for(int i=0; i<particles.length; i++) {
    particles[i] = new RandomWalker(10, size*30, width/2, 10);
  }
  
  font = createFont("KGNoRegretsSketch.ttf", 100);
  textFont(font);
  textSize(40);
}
       
void draw() {
  background( lerpColor(bg1, bg2, sin(frameCount*beatRate)), 1 );
  
  for (int i=0; i<particles.length; i++) {
    particles[i].walk(pc1, pc2, i);
  }
  
  hearts.draw(size, beatRate, phase);
  
  fill(#9dabd3, 255-frameCount*0.1);
  stroke(255);
  /*String mtext = "Feliz día de las madres!!";
  float w = textWidth(mtext);
  text(mtext, width/2-w/2, 0.2*height);*/
  
  // GIF>=======================
  export();
  // GIF<=======================
}

// GIF>=======================
void export() {
  if(frames < totalFrames) {
    gifExport.setDelay(20);
    gifExport.addFrame();
    frames++;
  } else {
    gifExport.finish();
    frames++;
    println("gif saved");
    exit();
  }
}
// GIF<=======================