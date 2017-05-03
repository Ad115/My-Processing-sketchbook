enum Sources
{
  SINK, SOURCE, NONE;
}

final Sources SOURCE = Sources.SOURCE;
final Sources SINK = Sources.SINK;
final Sources NONE = Sources.NONE;


// ******************************************************************************


enum Distributions
{
  TOP, BOTTOM, CENTER, NOISE_HORIZONTAL, NOISE_VERTICAL, RANDOM;
}

class SourceDistribution
{
  Distributions setting;
  
  SourceDistribution(Distributions distribution)
  {
    this.setting = distribution;
  }
  
  Sources[][] getDistribution(int rows, int cols, Sources sourceType)
  {
    Sources[][] distribution = new Sources[rows][cols];
    
    switch (setting)
    {
      case TOP:
      {
        for (int i=0; i<rows; i++)
        { for (int j=0; j<cols; j++)
          { 
            if (i == 0)  {  distribution[i][j] = sourceType; }
            else  {  distribution[i][j] = Sources.NONE; }
          }
        }
        break;
      }
      case BOTTOM:
      {
        for (int i=0; i<rows; i++)
        { for (int j=0; j<cols; j++)
          { 
            if (i+1 == rows)  {  distribution[i][j] = sourceType; }
            else  {  distribution[i][j] = Sources.NONE; }
          }
        }
        break;
      }
      case CENTER:
      {
        for (int i=0; i<rows; i++)
        { for (int j=0; j<cols; j++)
          { 
            if (i == rows/2 && j == cols/2)  {  distribution[i][j] = sourceType; }
            else  {  distribution[i][j] = Sources.NONE; }
          }
        }
        break;
      }
      case NOISE_VERTICAL:
      {
        float offset = random(10000);
        for (int i=0; i<rows; i++)  
        { 
          int jj = int(cols*noise(i*0.05 + offset));
          for (int j=0; j<cols; j++)
          {
            if (j == jj)  {  distribution[i][j] = sourceType; }
            else  {  distribution[i][j] = NONE; }
          }
        }
      break;
      }
      case NOISE_HORIZONTAL:
      {
        float offset = random(10000);
        for (int j=0; j<cols; j++)  
        { 
          int ii = int(rows*noise(j*0.05 + offset));
          for (int i=0; i<rows; i++)
          {
            if (i == ii)  {  distribution[i][j] = sourceType; }
            else  {  distribution[i][j] = NONE; }
          }
        }
      break;
      }
      case RANDOM:
      {
        for (int j=0; j<cols; j++)  
        { for (int i=0; i<rows; i++)
          { 
            float r = random(100);
            if (r < 0.5)  {  distribution[i][j] = sourceType; } // 0.5% probability to be selected
            else  {  distribution[i][j] = NONE; }
          }
        }
      break;
      }
    }
    return distribution;
  }
}