String letters = "";
int back = 102;
int tex = 30;
PFont NRSketch, NRSolid;

void setup() {
  fullScreen();
  textAlign(CENTER);
  NRSketch = createFont("KGNoRegretsSketch.ttf", 100);
  NRSolid = createFont("KGNoRegretsSolid.ttf", 100);
  textFont(NRSketch);
}

void draw() {
  background(back);
  fill(tex);
  text(letters, width/2, height/2);
}

void keyPressed() {
  if ((key == ENTER) || (key == RETURN)) {
    letters = letters.toLowerCase();
    println(letters); // Print to console to see input
    if (letters.equals("black")) {
      back = 0;
      tex = 105;
      textFont(NRSolid);
    } else if (letters.equals("gray")) {
      back = 102;
      tex = 30;
      textFont(NRSketch);
    }
    letters = ""; // Clear the variable
  } else if ((key > 31) && (key != CODED)) {
    // If the key is alphanumeric, add it to the String
    letters = letters + key;
  }
}