class CellularAutomaton
{
  Cell[][] grid;
  Cell[][] previous;
  int cols;
  int rows;
  float preyDensity, predatorDensity;
  
  //.....................................................
  
  CellularAutomaton(float cellSize, float predatorDensity, float preyDensity)
  { 
    // Calculate dimensions of the grid
    cols = int(width/cellSize)-2;
    rows = int(height/cellSize)-2;
    
    // Initialize a randomized grid
    this.preyDensity = preyDensity;
    this.predatorDensity = predatorDensity;
    this.initializeGrids();
  }
  
  //.....................................................
  
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
        if (grid[i][j].isAlive())
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
  
  //.....................................................
  
  void step()
  {
    // Save a snapshot of the current state
    this.saveStates();
    // Update the state of each cell
    for (int i=0; i<rows; i++)
    { for(int j=0; j<cols; j++)
      {
        grid[i][j] = grid[i][j].steppedFrom(previous[i][j]);
      }
    }
  }
  
  //.....................................................
  
  int aliveNeighbourCount(int i, int j)
  {


    int count = 0;
    for(int horOffset = -1; horOffset <= 1; horOffset++)
    {
      for(int vertOffset = -1; vertOffset <= 1; vertOffset++)
      {
        int ii = (i + vertOffset + rows) % rows;
        int jj = (j + horOffset + cols) % cols;
        if (previous[ii][jj].isAlive())
        {
          if ((ii != i) || (jj != j)) {count++;}
        }
      }
    }
    return count;
  }
  
  //.....................................................
  
  void saveStates()
  {
    for (int i=0; i<rows; i++)
    { for(int j=0; j<cols; j++)
      {
         previous[i][j] = previous[i][j].setAs(grid[i][j]);
      }
    }
  }
  
  //.....................................................
  
  void reset()
  {
    for(int i=0; i<rows; i++)
    { 
      for (int j=0; j<cols; j++)
      {
        float s = noise(noiseRate*i, noiseRate*j);
        if (s < seedProbability)  {  grid[i][j].Live(); }
        else  {  grid[i][j].Die(); } 
      }
    }
  }
  
  //.....................................................
  
  void clear()
  {
    for(int i=0; i<rows; i++)
    { 
      for (int j=0; j<cols; j++)
      {
        grid[i][j].Die();
      }
    }
  }
  
  //.....................................................
  
  void addAt(float x, float y)
  {
    int i = int(y/height * rows);
    int j = int(x/width * cols);
    grid[i][j].Live();
  }
  
  void initializeGrids()
  {
    this.grid = new Cell[rows][cols];
    this.previous = new Cell[rows][cols];
    for(int i=0; i<rows; i++)
    { for (int j=0; j<cols; j++)
      { 
        float preyOffset = random(10000);
        float preySeed = noise(noiseRate*i + preyOffset, noiseRate*j + preyOffset);
        if(preySeed < preyDensity)  {  grid[i][j] = new Prey();}
        
        float predatorOffset = random(10000);
        float predatorSeed = noise(noiseRate*i + predatorOffset, noiseRate*j + predatorOffset);
        if(predatorSeed < preyDensity)  {  grid[i][j] = new Predator();}
      }
    }
    this.setNeighbors();
  }
  
  //.....................................................
  
  void setNeighbors()
  {
    for(int i=0; i<rows; i += NEIGHBORHOOD_RADIUS+1)
    { for (int j=0; j<cols; j += NEIGHBORHOOD_RADIUS+1)
      { 
        for (int iOffset = -NEIGHBORHOOD_RADIUS; iOffset <= NEIGHBORHOOD_RADIUS; iOffset++)
        { for (int jOffset = -NEIGHBORHOOD_RADIUS; jOffset <= NEIGHBORHOOD_RADIUS; jOffset++)
          {
            int ii = (i + iOffset + rows) % rows; // periodic boundary
            int jj = (j + jOffset + cols) % cols; // Periodic boundary
            grid[i][j].setNeighbor(grid[ii][jj], iOffset, jOffset);
            grid[ii][jj].setNeighbor(grid[i][j], -iOffset, -jOffset);
          }
        }
      }
    }
  }
  
  //.....................................................
  
}