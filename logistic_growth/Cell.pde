abstract class Cell
{
  final boolean ALIVE = true;
  final boolean DEAD = false;
  
  boolean state;
  Cell[] neighbors;
  
  //.....................................................
  
  Cell() {}
  
  Cell(int neighborhoodRadius)  
  { 
    float numberOfNeighbors = pow( (float)(2*neighborhoodRadius-1), 2);
    neighbors = new Cell[int(numberOfNeighbors)]; 
  } 
  
  //.....................................................
  
  void Live()  {state = ALIVE;}
  
  void Die()  {state = DEAD; }
  
  boolean isAlive()  {  return (state == ALIVE) ? true : false; }
  
  void copyState(Cell other)  {  if(other.isAlive()) {this.Live();} else {this.Die();} }
  
  void setNeighbors(Cell[] neighbors)  {  this.neighbors = neighbors; }
  
  Cell[] getNeighbors()  {  return this.neighbors; }
  
  Cell steppedFrom(Cell previous)  {  return this.SetAs(previous.step()); }
  
  //.....................................................
  
  void setNeighbor(Cell neighbor, int iOffset, int jOffset)
  {
    int ii = NEIGHBORHOOD_RADIUS + iOffset;
    int jj = NEIGHBORHOOD_RADIUS + jOffset;
    int rows = 2*NEIGHBORHOOD_RADIUS + 1;
    int index = rows*ii + jj;
    neighbors[index] = neighbor;
  }
  
  //.....................................................

  Cell setAs(Cell other)
  {
    Cell result;
    if(other.isSameSpeciesAs(this))
    {  
      this.copyState(other);
      result = this;
    }
    else  
    {  
      result = other.newCopy();
      result.setNeighbors( this.getNeighbors() );
    }
    return result;
  }
  
  //.....................................................
  
  Cell newCopy()
  {
    Class species = this.species();
    
    Cell copy = null; 
    try  {  copy = (Cell) species.newInstance(); }  catch(Exception e)  {  println(e); }
    
    copy.copyState(this);
    return copy;
  }
  
  //.....................................................
    
  Cell step()
  {
     
  }
  
  //.....................................................
  
  abstract void draw(float x, float y);
  
  //.....................................................
}


// ******************************************************************************


class PREDATOR extends Cell
{  
  //.....................................................
  
  void draw(float x, float y)
  {
  }
  
  //.....................................................  
}


// ******************************************************************************


class PREY extends Cell
{
  //.....................................................
  
  void draw(float x, float y)
  {
  }
  
  //.....................................................
}