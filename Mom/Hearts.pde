class Hearts {
  PShape[] hearts;
  Hearts(int n, color f1, color f2) {
    hearts = createHearts(n, f1, f2);
    
  }
  
  PShape[] createHearts(int n, color f1, color f2) {
    color c;
    PShape[] h = new PShape[n];
    
    for (int i=0; i<n; i++) {
      c = lerpColor(f1, f2, (i+0.0)/n);
      h[i] = createShape();
      h[i].beginShape();
        h[i].noStroke();
        h[i].fill(c, 200);
        float t = 0;
        float x = heartX(t);
        float y = heartY(t);
        h[i].vertex(x, y);
        float arc = 0.05;
        for (float angle = 0; angle < TAU; angle += arc) {
            t = angle;
            x = heartX(t);
            y = heartY(t);
            h[i].vertex(x, y);
        }
        h[i].vertex(x, y);
      h[i].endShape(CLOSE);
    }
    return h;
  }
  
  void draw(float size, float beatRate, float phase) {
    float s0 = size/2;
    float s_step = (size-s0)/hearts.length;
    float s;
    
    translate(width/2, height/2);
    for (int i=hearts.length-1; i>=0; i--) {
      s = s0+i*s_step;
      pushMatrix();
        scale(s*sin(frameCount*beatRate+ i*phase)+ s);
        shape(hearts[i]);
      popMatrix();
    }
    translate(-width/2, -height/2);
  }
  
  
  float heartX(float t) {
    return 16*pow(sin(t), 3);
  }
  
  float heartY(float t) {
    return -13*cos(t) + 5*cos(2*t) + 2*cos(3*t) + cos(4*t);
  }
}