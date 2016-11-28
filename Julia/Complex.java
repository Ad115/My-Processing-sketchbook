class Complex
{
  double r, i; // Real and imaginary parts
  
  Complex(double real_part, double imaginary_part)
  {
    this.r = real_part;
    this.i = imaginary_part;
  }
  
  Complex(double r)
  {
    this.r = Math.random() * r;
    this.i = Math.random() * i;
  }
  
  static Complex random(float xMin, float xMax, float yMin, float yMax)
  {
    Double r = (Math.abs(xMax - xMin) * Math.random()) + (xMax > xMin ? xMin : xMax);
    Double i = (Math.abs(yMax - yMin) * Math.random()) + (yMax > yMin ? yMin : yMax);
    return new Complex(r, i);
  }
  
  void add(Complex c)
  {
    this.r += c.r;
    this.i += c.i;
  }
  
  void mult(Complex c)
  {
    double r1 = this.r;
    double i1 = this.i;
    double r2 = c.r;
    double i2 = c.i;
    this.r = (r1 * r2) - (i1 * i2);
    this.i = (r1 * i2) + (i1 * r2);
  }
  
  static Complex mult(Complex a, Complex b)
  {
    return new Complex(a.r*b.r - a.i*b.i , a.r*b.i + a.i*b.r);
  }
  
  double magnitudeSq()
  {
    return this.r*this.r + this.i*this.i;
  }
  
  static Complex copy(Complex c)
  {
    return new Complex(c.r, c.i);
  }
  
  void mapToUnitSquare(float x0, float x1, float y0, float y1)
  {
    this.r = (this.r-x0)/(x1-x0);
    this.i = (this.i-y0)/(y1-y0);
    
  }
}