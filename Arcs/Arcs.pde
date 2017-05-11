class Arcs
{
  int t, n;
  float wiggleRate = 0.01;
  float unitOffWiggle = 3;
  float shadeRate = 0.03;
  float unitOffShade = 4;
  float shadeAmp = 75;
  
  Arcs(int n)
  {
    this.n = n;
    this.t = int(random(1000));
  }
  
  void draw()
  {
    int size;
    if (width > height) 
      {size = (height - 50);}
    else 
      {size = (width - 50);}
      
    int offShade=0;
    int offWiggle=0;
    int w = size/n;
    for(int s=size; s>0; s -= w)
    {
      // Draw circle
      ellipseMode(CENTER);
      stroke(100); noFill(); strokeWeight(10);
      ellipse(width/2, height/2, s, s);
      
      // Draw arc
      stroke(0, 130);
      strokeWeight(shadeAmp*noise(100+(t+offShade)*shadeRate));
      float a = noise((t+offWiggle)*wiggleRate);
      a = map(a, 0, 1, 0, 2*TAU);
      float b = noise(1000 + (t+offWiggle)*wiggleRate);
      b = map(b, 0, 1, 0, TAU);
      arc(width/2, height/2, s, s, a, a+b);
      
      offShade += unitOffShade;
      offWiggle += unitOffWiggle;
    }
    t+=1;
  }
    
  void reset() 
  { 
    this.t = int(random(1000));
  }
    
  void update(int n) { this.n = n; }

}