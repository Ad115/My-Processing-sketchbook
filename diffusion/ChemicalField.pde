class ChemicalField
{
  float[][] site, previous;
  int cols, rows;
  float cellSize, diffusionConstant;
  int[] source;
  
  //.....................................................
  
  // CONSTRUCTOR

  ChemicalField(float cellSize, float diffusionConstant, int[] source)

  { 
    // Calculate dimensions of the grid

    this.cellSize = cellSize;

    this.diffusionConstant = diffusionConstant;

    
    cols = int(width/cellSize);
    rows = int(height/cellSize);
    
    this.source = new int[cols];
    this.source = getSource(source);
    // Initialize grids
    site = new float[rows][cols];
    previous = new float[rows][cols];
    // Set grids to zero
    clear();
  }
  
  //.....................................................
  
  
  void clear()
  {  // Set grids to zero
    for(int i=0; i<rows; i++)
    { for (int j=0; j<cols; j++)
      { site[i][j] = 0;
        previous[i][j] = 0;
        if (source[j] == i)  {  site[i][j] = sourceConcentration; }
      }
    }
  }
  
  //.....................................................
  
  void step()
  { 
    // Save a snapshot of the current state

    saveStates();
    
    // Update the state of selected cells
    float dt = 1/timeUnit;
    for (int i=0; i<rows; i++) //<>//

    { for(int j=0; j<cols; j++)
      { 
        if(source[j] == i)  { site[i][j] = sourceConcentration; } // You are in the source







else  {site[i][j] = previous[i][j] + delta(i, j)*dt; } // Calculate the new value
      //site[i][j] = constrain(site[i][j], 0, sourceConcentration);
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
  
  float delta(int i, int j)
  {





    float D = diffusionConstant;




    float delta = D*laplacian(i, j);
    return delta;
  }
  
  //.....................................................
  
  float laplacian(int i, int j)
  {

    int jj = (j+cols); // To apply modulus operator //<>//
    float local = previous[i][j];
    
    float differential = (previous[i][(jj+1) % cols] - local) 
                         + (previous[i][(jj-1) % cols] - local);
    if (i-1 >= 0) 
      {  differential += (previous[i-1][j] - local); } // Check if you are not in the top of the screen
    if (i+1 < rows) 
      { differential += (previous[i+1][j] - local);} // Check if you are not in the bottom of the screen
      
    float h = cellSize / lengthUnit;
    float laplacian = differential / (h*h);
    return laplacian;
  }
  
  //.....................................................
  
  int[] getSource(int[] source)
  {
    int[] result = new int[cols];
    for (int i=0; i<result.length; i++)
    { int index = int(i * cellSize/2);
      result[i] = int(source[index]/cellSize);
    }
    return result;
  }   
  
  
  //.....................................................
  
  void draw()
  {  

    noStroke();

    rectMode(CENTER);
    for (int i=0; i<rows; i++)
    { for (int j=0; j<cols; j++)
      { //Draw the cell
        float alpha = map(site[i][j], 0, sourceConcentration, 0, 255);
        fill(0, alpha);
        float y = i*cellSize + cellSize/2;
        float x = j*cellSize + cellSize/2;
        rect(x, y, cellSize, cellSize);
        fill(150);
        if(alpha > 255 || alpha < 0) { fill(255, 0, 0);}
        textSize(12);
        float percentage = site[i][j]/sourceConcentration * 100;
        text(int(percentage), j*cellSize, y);
      }
    }
  }
  
  //.....................................................
  
}