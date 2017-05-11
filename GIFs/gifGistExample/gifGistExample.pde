import gifAnimation.*;

GifMaker gifExport;
int frames = 0;
int totalFrames = 120;

public void setup() {
  smooth();
  size(400, 400);

  gifExport = new GifMaker(this, "export.gif", 100);
  gifExport.setRepeat(0); // make it an "endless" animation

  noFill();
  stroke(0);
  strokeWeight(20);
}

void draw() {
  background(255);

  float size = 100.0 * sin(TWO_PI * frames / float(totalFrames)) + 200.0;
  ellipse(width/ 2.0, height / 2.0, size, size);
  export();
}

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