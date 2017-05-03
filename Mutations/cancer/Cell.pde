static enum CellType
{ HEALTHY,
  CANCEROUS,
  DEAD;
}
   
//******************************************************************

class Cell
{
  CellType cellType;
  int n;
  
  // Constructor
  Cell()
  { this.cellType = HEALTHY;
    this.n = 1;
  } // End of constructor
  
  boolean isAlive()
  { boolean isAlive = false;
    if(cellType != DEAD)  { isAlive = true;}
    return isAlive;
  }
  
  boolean isCancerous()
  { boolean isCancerous = false;
    if(cellType == CANCEROUS)  { isCancerous = true;}
    return isCancerous;
  }
    
  void addCancerous()
  { if (this.isCancerous())  {  n++; }
    else
    { this.cellType = CANCEROUS;
      this.n = 1;
    }
  }
  
  int cancerousCount()
  { int cancerous = 0;
    if (this.isCancerous())  {  cancerous += n; }
    return cancerous;
  }
  
  int normalCount()
  { int normal = 0;
    if (!this.isCancerous())  {  normal += n; }
    return normal;
  }
  
  void die()
  { n--;
    if (n == 0)  {  this.cellType = DEAD; }
  }
  
  void drawCell(float x, float y, float cellSize)
  { switch (this.cellType)
    case 
    case CANCEROUS: {  fill(
       
}