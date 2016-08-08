class CellGrid
{
  Cell[][] site;
  Cell[][] previous;
  int cols;
  int rows;
  float updateProbability;
  
  //.....................................................
  
  // CONSTRUCTOR
  CellGrid(float cellSize)
  { 
    // Calculate dimensions of the grid
    cols = int(width/cellSize);
    rows = int(height/cellSize);
    
    // Initialize grids
    site = new Cell[cols][rows];
    previous = new Cell[cols][rows];
    for(int i=0; i<rows; i++)
    { for (int j=0; j<cols; j++)
      { site[i][j] = new Cell();
        previous[i][j] = new Cell();
      }
    }
  } 
  
  //.....................................................
  
  void draw()
  {
    background(0);
    rectMode(CENTER);
    noStroke();
    
    for (int i=0; i<rows; i++)
    { for (int j=0; j<cols; j++)
      { // Get positions on the screen
        float x = j*cellSize + cellSize/2;
        float y = i*cellSize + cellSize/2;
        
        // Draw cell
        site[i][j].drawCell(x, y, cellSize);
      }
    }
  }
  
  //.....................................................
  
  void step()
  {
    // Save a snapshot of the current state
    saveStates();
    
    // Update the state of selected cells
    for (int i=0; i<rows; i++)
    { for(int j=0; j<cols; j++)
      { float r = random(100);
        if (event(updateProbability))
        { // The cell is selected to be updated
           
          
        
      }
    }
  }
  
  //.....................................................
  
  void saveStates()
  {
    for (int i=0; i<rows; i++)
    { for(int j=0; j<cols; j++)
      {  cell[i][j].copy(previous[i][j]); }
    }
  }
  
  //.....................................................
                  
}