class FractalPoint
{
  int x;
  int y;
  int escape;
  
  FractalPoint(int x, int y, int escape)
  {
    this.x = x;
    this.y = y;
    this.escape = escape;
  }
}

class Fractal
{
  int width;
  int height;
  ArrayList <FractalPoint> points;
  Complex C;
  
  Fractal()  {}
  
  void init(int width, int height)
  {
    this.points = new ArrayList<FractalPoint>();
    this.width = width;
    this.height = height;
    this.C = new Complex(1.0);
  }
  
  void getPoint()
  // Sets the escape value of a new point
  {
    // Set the initial point
    Complex c = Complex.random(0, width, 0, height);
    Complex initialChoords = Complex.copy(c);
    c.mapToUnitSquare(0, width, 0, height);
    for (int i=0; i<100; i++)
    {
      // Transforms c -> c*c + C
      c.mult(c);
      c.add(this.C);
      print(c.magnitudeSq() + "\n");
    }
    
    // Assign the escape value to the corresponding slot in the grid
    int x = (int)(initialChoords.r); //<>//
    int y = (int)(initialChoords.i);
    print(c.magnitudeSq() + "\n\n");
    int escape = ((new Double(c.magnitudeSq()))).intValue();
    if (escape != 0)  { points.add(new FractalPoint(x, y, escape)); }
  }
  
  
  void update()
  {

    for (int i=0; i<10; i++)
    {

      getPoint(); //<>//
    }
  }
  
  void draw()
  {
    int n_points = this.points.size(); 
    for (int i=0; i<n_points; i++)
    {
      FractalPoint point = this.points.get(i);
      if (point.escape < 100)  {fill(255);}
      else { fill(0);}
      noStroke();
      ellipse(point.x, point.y, 10, 10);
    }
  }
  
}