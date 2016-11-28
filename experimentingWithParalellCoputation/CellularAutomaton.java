package gameOfLife;

import java.util.concurrent.*;
import processing.core.*;

public class CellularAutomaton
{
  Cell[][] cell;
  Cell[][] previousCell;
  int cols;
  int rows;
  float seedProbability;

  CellularAutomaton(float cellSize, float seedProbability)
  {
    // Calculate dimensions of the grid
    cols = int(width/cellSize);
    rows = int(height/cellSize);

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

    this.initNeighbors();
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
    Cell[] cells = new Cell[rows*cols];
    for (int i=0; i<rows; i++)
    {
      for(int j=0; j<cols; j++)
      {
        cells[i*cols + j] = cell[i][j];
      }
    }

    ForkJoinPool process = ForkJoinPool.commonPool();
    process.invoke(new StepComputation(cells));
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
    float r = random(1000);
    for(int i=0; i<rows; i++)
    {
      for (int j=0; j<cols; j++)
      {
        float s = noise(noiseRate*i + r, noiseRate*j + r);
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

  void initNeighbors()
  {

    Cell[] neighbors = new Cell[9];

    for (int i=0; i<rows; i++)
    { for (int j=0; j<cols; j++)
      {
        for(int vertOffset = -1; vertOffset <= 1; vertOffset++)
        { for(int horOffset = -1; horOffset <= 1; horOffset++)
          {
            int ii = (i + vertOffset + rows) % rows;
            int jj = (j + horOffset + cols) % cols;
            neighbors[(vertOffset+1)*3 + (horOffset+1)] = previousCell[ii][jj];
          }
        }
        cell[i][j].setNeighbors(neighbors);
      }
    }
  }


}


class Cell
{
  boolean state;
  Cell[] neighbors = new Cell[9];

  Cell(float seedProbability, int i, int j)
  {
    float s = noise(noiseRate*i, noiseRate*j);
    if(s < seedProbability) {this.Live();}
    else    {this.Die();}
  }

  void setNeighbors(Cell[] neighbors)
  {
    for (int i=0; i<this.neighbors.length; i++)
    {
      this.neighbors[i] = neighbors[i];
    }
  }

  void Live()  {state = true;}

  void Die()  {state = false;}

  boolean isAlive()  {return state;}

  int aliveNeighborsCount()
  {
    int count = 0;
    for ( int i=0; i<neighbors.length; i++ )
    {  if (neighbors[i].isAlive())  {  count++; } }
    if (this.isAlive())  {  count--; }
    return count;
  }
}

  class StepComputation extends RecursiveAction
  {
      final int SEQUENTIAL_TRESHOLD = 50;
      Cell[] cells;
      int init = 0;
      int end;

      StepComputation(Cell[] cells)
      {
          this.cells = cells;
          init = 0;
          end = cells.length-1;
      }

      StepComputation(Cell[] cells, int init, int end)
      {
          this.cells = cells;
          this.init = init;
          this.end = end;
      }


      @Override public void compute()
      {
          if(end-init <= SEQUENTIAL_TRESHOLD)
          {
              for( int i=init; i<end; i++)
                int aliveNeighbors = cells[i].aliveNeighborsCount();
                if(cells[i].isAlive())
                {
                  if(aliveNeighbors < 2)  {  cells[i].Die(); } // Die of solitude
                  else if (aliveNeighbors > 3)  {  cells[i].Die(); } // Die of overpopulation
                }
                else // It is a dead cell
                  if (aliveNeighbors == 3)  {  cells[i].Live(); } // Just the right number
          }
          else
          {
              int mid = init + (end-init)/2;
              StepComputation left = new StepComputation(cells, init, mid);
              StepComputation right = new StepComputation(cells, mid, end);

              right.fork();
              left.compute();
              right.join();
          }
      }
  }
