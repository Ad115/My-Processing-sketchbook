class Hearts {
  int n;
  color f1; 
  color f2;
  Hearts(int n, color f1, color f2) {
    this.n = n;
    this.f1 = f1;
    this.f2 = f2;
  }
  
  void draw(float size, float beatRate, float phase) {
    float s0 = size/2;
    float s_step = (size-s0)/n;
    float s;
    color c;
    
    translate(width/2, height/2);
    for (int i=n-1; i>=0; i--) {
      s = s0+i*s_step;
      pushMatrix();
        scale(s*sin(frameCount*beatRate+ i*phase)+ s);
        
        // Draw shapes
        c = lerpColor(f1, f2, (i+0.0)/n);
        noStroke();
        fill(c, 200);
        beginShape(); 
          float t = 0;
          float x = heartX(t);
          float y = heartY(t);
          vertex(x, y);
          float arc = 0.05;
          for (float angle = 0; angle < TAU; angle += arc) {
              t = angle;
              x = heartX(t);
              y = heartY(t);
              vertex(x, y);
          }
          vertex(x, y);
        endShape(CLOSE);
      
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