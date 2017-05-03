// Just testing java tabs in processing

class Something
{
  int i;
  private Something(int i)
  {
    this.i = i;
  }
  
  static Something makeSomething(int i)
  {
    return new Something(i);
  }
}