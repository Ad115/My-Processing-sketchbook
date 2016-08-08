static enum Nutrient
{ ESSENTIAL,
  NON_ESSENTIAL,
  GROWTH_FACTOR;
}
  
//******************************************************************

class ChemicalField
{
  float[][] site;
  float[][] previous;
  Nutrient nutrientType;
  int cols;
  int rows;
  float cellSize;
  
  // Simulation parameters
  float vesselNutrient;
  float updateRadius;
  
  //.....................................................
  
  // CONSTRUCTOR
  ChemicalField(float cellSize, Nutrient nutrientType)
  { 
    // Calculate dimensions of the grid
    this.cellSize = cellSize;
    cols = int(width/cellSize);
    rows = int(height/cellSize);
    
    this.nutrientType = nutrientType;
    
    // Initialize grids
    site = new float[cols][rows];
    previous = new float[cols][rows];
    for(int i=0; i<rows; i++)
    { for (int j=0; j<cols; j++)
      { site[i][j] = vesselNutrient;
        previous[i][j] = 0;
      }
    }
  } 
  
  //.....................................................
  
  void updateNeighborhood(int i, int j, float dt, int cancerousCells, int normalCells)
  { 
    // Save a snapshot of the current state
    saveStates(i, j);
    
    // Update the state of selected cells
    for (float vertOffset = -updateRadius; vertOffset < updateRadius; vertOffset++)
    { for(float horiOffset = -updateRadius; horiOffset < updateRadius; horiOffset++)
      { int ii = int(i + vertOffset);
        int jj = int(j + horiOffset + width) % width; // Periodic boundary conditions
        if (ii < rows)
        { int c = cancerousCells; int n = normalCells;
          site[ii][jj] = previous[ii][jj] + delta(ii, jj, c, n)*dt; // Calculate the new value
        }
      }
    }
  }
  
  //.....................................................
  
  void saveStates(int i, int j)
  {
    for (float vertOffset = -updateRadius; vertOffset < updateRadius; vertOffset++)
    { for(float horiOffset = -updateRadius; horiOffset < updateRadius; horiOffset++)
      { int ii = int(i + vertOffset);
        int jj = int(j + horiOffset + width) % width; // Periodic boundary conditions
        if (ii < rows)  {  previous[ii][jj] = site[ii][jj]; }
      }
    }
  }

  //.....................................................
  
  void saveStates()
  {
    for (int i=0; i<rows; i++)
    { for(int j=0; j<cols; j++)
      { previous[i][j] = site[i][j];
      }
    }
  }
  
  //.....................................................
  
  float delta(int i, int j, int cancerousCells, int normalCells)
  {
    float alpha = nutrientType.consumption(); 
    float lambda = nutrientType.cancerousConsumption();
    float delta = laplacian(i, j) - alpha*(normalCells + lambda*cancerousCells);
    return delta;
  }
  
  //.....................................................
  
  float laplacian(int i, int j)
  {
    j = (j+cols) % cols; // Periodic boundary
    float neighbors = previous[i][j+1] + previous[i][j-1]
                      + previous[i-1][j+1];
    if (i+1 < rows)  { neighbors += previous[i+1][j]; } // If not in the border yet
    float local = 4*previous[i][j];
    float h = cellSize;
    float laplacian = (neighbors - local) / (h*h);
    return laplacian;
  }
  
  //.....................................................
  
  void updateAll(CellGrid cells, float dt)
  {
    // Save a snapshot of the current state
    saveStates();
    
    // Update the state of every cell
    for (int i=0; i<rows; i++)
    { for (int j=0; j<cols; j++)
      { int ii = i;
        int jj = (j + width) % width; // Periodic boundary conditions
        if (ii < rows)
        { int c = cells[ii][jj].cancerousCount();
          int n = cells[ii][jj].normalCount();
          site[ii][jj] = previous[ii][jj] + delta(ii, jj, c, n)*dt; // Calculate the new value
        }
      }
    }
  }
                  
}