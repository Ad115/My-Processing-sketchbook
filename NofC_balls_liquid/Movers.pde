class Balls
{
  int n_balls;
  BouncingBall[] balls;
  
  Balls(int n_balls)
  {
    this.n_balls = n_balls;
    
    balls = new BouncingBall[n_balls];
    for(int i=0; i<n_balls; i++)
      { balls[i] = new BouncingBall(); }  
  }
  
  void update()
  {
    for(int i=0; i<n_balls; i++)
      { balls[i].update(); }
  }
  
  void draw()
  {
    for(int i=0; i<n_balls; i++)
      { balls[i].draw(); }
  }
  
  void move()
  {
    for(int i=0; i<n_balls; i++)
      { balls[i].move(); }
  }
  
  void randomize(float r)
  {
    for(int i=0; i<n_balls; i++)
      { balls[i].randomize(r); }
  }
  
  void feelDrag(Liquid liquid)
  {
    for (int i=0; i<n_balls; i++)
    {
      balls[i].feelDrag(liquid);
    }
  }
}