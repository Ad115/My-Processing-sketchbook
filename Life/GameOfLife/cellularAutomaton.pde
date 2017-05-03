class CellularAutomaton
{
  Cell[][] cell;
  Cell[][] previousCell;
  int cols;
  int rows;
  float seedProbability;
  
  CellularAutomaton(float cellSize, float seedProbability)
  { 
    // Calculate dimensions of the grid
    cols = int(width/cellSize)-2;
    rows = int(height/cellSize)-2;
    
    // Initialize a randomized grid
    this.seedProbability = seedProbability;
    cell = new Cell[rows][cols];
    previousCell = new Cell[rows][cols];
    for(int i=0; i<rows; i++)
    { 
      for (int j=0; j<cols; j++)
      { 
        cell[i][j] = new Cell(seedProbability, i, j);
        previousCell[i][j] = new Cell(seedProbability, i, j); 
      }
    }
  }
  
  void draw()
  {
    background(0);
    //rectMode(CENTER);
    ellipseMode(CENTER);
    fill(255, 200);
    noStroke();
    for (int i=0; i<rows; i++)
    {
      for (int j=0; j<cols; j++)
      {
        if (cell[i][j].isAlive())
        {
          // Get positions on the screen
          float x = j*cellSize + cellSize/2;
          float y = i*cellSize + cellSize/2;
          
          if(!drawing)
          {
            x += cellSize/2*random(1);
            y += cellSize/2*random(1);
          }
          
          // Draw cell
          ellipse(x, y, cellSize, cellSize);  
          //rect(x, y, cellSize, cellSize);
        }
      }
      
    }
  }
  
  void step()
  {
    // Save a snapshot of the current state
    saveStates();
    // Update the state of each cell
    for (int i=0; i<rows; i++)
    {
      for(int j=0; j<cols; j++)
      {
        int aliveNeighbors = aliveNeighbourCount(i, j);  
        if(cell[i][j].isAlive())
        {
          if(aliveNeighbors < 2)  {  cell[i][j].Die(); } // Die of solitude
          else if (aliveNeighbors > 3)  {  cell[i][j].Die(); } // Die of overpopulation
        }
        else // It is a dead cell
        {
          if (aliveNeighbors == 3)  {  cell[i][j].Live(); } // Just the right number
        }
      }
    }
  }
  
  int aliveNeighbourCount(int i, int j) //<>//
  {


    int count = 0; //<>//
    for(int horOffset = -1; horOffset <= 1; horOffset++) //<>//
    {
      for(int vertOffset = -1; vertOffset <= 1; vertOffset++)
      {
        int ii = (i + vertOffset + rows) % rows;
        int jj = (j + horOffset + cols) % cols;
        if (previousCell[ii][jj].isAlive())
        {
          if ((ii != i) || (jj != j)) {count++;}
        }
      }
    }
    return count;
  }
  
  void saveStates()
  {
    for (int i=0; i<rows; i++)
    {
      for(int j=0; j<cols; j++)
      {
        if(cell[i][j].isAlive())  {  previousCell[i][j].Live(); }
        else  {  previousCell[i][j].Die(); }
      }
    }
  }
  
  void reset()
  {
    for(int i=0; i<rows; i++)
    { 
      for (int j=0; j<cols; j++)
      {
        float s = noise(noiseRate*i, noiseRate*j);
        if (s < seedProbability)  {  cell[i][j].Live(); }
        else  {  cell[i][j].Die(); } 
      }
    }
  }
  
  void clear()
  {
    for(int i=0; i<rows; i++)
    { 
      for (int j=0; j<cols; j++)
      {
        cell[i][j].Die();
      }
    }
  }
  
  void addAt(float x, float y)
  {
    int i = int(y/height * rows);
    int j = int(x/width * cols);
    cell[i][j].Live();
  }
}


class Cell
{
  boolean state;
  
  Cell(float seedProbability, int i, int j)
  {
    float s = noise(noiseRate*i, noiseRate*j);
    if(s < seedProbability) {this.Live();}
    else    {this.Die();}
  }
  
  void Live()  {state = true;}
  
  void Die()  {state = false;}
  
  boolean isAlive()  {return state;}
}