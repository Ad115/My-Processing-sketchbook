enum Sources
{
  SINK, SOURCE, NONE;
}
final Sources SOURCE = Sources.SOURCE;
final Sources SINK = Sources.SINK;
final Sources NONE = Sources.NONE;


// ******************************************************************************


interface SourceDistribution
{  
  Sources[][] getDistribution(int rows, int cols, Sources sourceType);
}


// ******************************************************************************


class SourcesAtTOP implements SourceDistribution
{
  SourcesAtTOP()  {}
  
  //.....................................................
    
  public Sources[][] getDistribution(int rows, int cols, Sources sourceType)
  { 
    Sources[][] distribution = new Sources[rows][cols];
     for (int i=0; i<rows; i++)
     { for (int j=0; j<cols; j++)
       { 
         if (i == 0)  {   distribution[i][j] = sourceType; }
         else  {  distribution[i][j] = Sources.NONE; }
       }
     }
     return distribution;
  }
  
  //.....................................................
}

  
// ******************************************************************************


class SourcesAtBOTTOM implements SourceDistribution
{
  SourcesAtBOTTOM()  {}
  
  //.....................................................
  
  public Sources[][] getDistribution(int rows, int cols, Sources sourceType)
  { 
    Sources[][] distribution = new Sources[rows][cols];
    for (int i=0; i<rows; i++)
    { for (int j=0; j<cols; j++)
      { 
        if (i == rows/2 && j == cols/2)  {  distribution[i][j] = sourceType; }
        else  {  distribution[i][j] = Sources.NONE; }
      }
    }
    return distribution;
  }
  
  //.....................................................
  
}


// ******************************************************************************


class SourcesAtCIRCLE implements SourceDistribution
{
  float relativeRadius;
  
  SourcesAtCIRCLE()  {  this.relativeRadius = (float)1/2; }
  
  SourcesAtCIRCLE(float relativeRadius)  {  this.relativeRadius = relativeRadius; }
  
  //.....................................................
  
  public Sources[][] getDistribution(int rows, int cols, Sources sourceType)
  { 
    Sources[][] distribution = new Sources[rows][cols]; //<>//
    float maxRadius = (rows < cols) ? rows/2 : cols/2;
    float radius = maxRadius * relativeRadius;
    
    for (int i=0; i<rows; i++)
    { for (int j=0; j<cols; j++)
      { 
        float currentDistance = dist(i, j, rows/2, cols/2);
        if ((radius-0.5 <= currentDistance) && (currentDistance <= radius+0.5))  
          {  distribution[i][j] = sourceType; }
        else  {  distribution[i][j] = Sources.NONE; }
      }
    }
    return distribution;
  }
  
  //..................................................... 
}

  
// ******************************************************************************


class SourcesAtCENTER implements SourceDistribution
{
  SourcesAtCENTER()  {}
  
  //.....................................................
  
  public Sources[][] getDistribution(int rows, int cols, Sources sourceType)
  { 
    Sources[][] distribution = new Sources[rows][cols];
    for (int i=0; i<rows; i++)
    { for (int j=0; j<cols; j++)
      { 
        if (i == rows/2 && j == cols/2)  {  distribution[i][j] = sourceType; }
        else  {  distribution[i][j] = Sources.NONE; }
      }
    }
    return distribution;
  }
  
  //..................................................... 
}

  
// ******************************************************************************
  
  
class SourcesAtRANDOM implements SourceDistribution
{
  float probability = 0.05;
  
  SourcesAtRANDOM()  {}
  
  SourcesAtRANDOM(float percentProbability)  {  this.probability = percentProbability; }
  
  //.....................................................
  
  public Sources[][] getDistribution(int rows, int cols, Sources sourceType)
  { 
    Sources[][] distribution = new Sources[rows][cols];
    for (int j=0; j<cols; j++)  
    { for (int i=0; i<rows; i++)
      { 
        float selector = random(100);
        if (selector < probability)  {  distribution[i][j] = sourceType; }
        else  {  distribution[i][j] = NONE; }
      }
    }
    return distribution;
  }
  
  //.....................................................  
}
  
  
// ******************************************************************************
  
  
class SourcesAtNOISE_VERTICAL implements SourceDistribution
{
  float noiseRate = 0.05;
  
  SourcesAtNOISE_VERTICAL()  {}
  
  SourcesAtNOISE_VERTICAL(float noiseRate)  {  this.noiseRate = noiseRate; }
  
  //.....................................................
  
  public Sources[][] getDistribution(int rows, int cols, Sources sourceType)
  { 
    Sources[][] distribution = new Sources[rows][cols];
    float offset = random(10000);
    for (int i=0; i<rows; i++)  
    { 
      int jj = int(cols*noise(i*noiseRate + offset));
      for (int j=0; j<cols; j++)
      {
        if (j == jj)  {  distribution[i][j] = sourceType; }
        else  {  distribution[i][j] = NONE; }
      }
    }
    return distribution;
  }
  
  //.....................................................  
}
  
  
// ******************************************************************************
  
  
class SourcesAtNOISE_HORIZONTAL implements SourceDistribution
{
  float noiseRate = 0.05;
  
  SourcesAtNOISE_HORIZONTAL()  {}
  
  SourcesAtNOISE_HORIZONTAL(float noiseRate)  {  this.noiseRate = noiseRate; }
  
  //.....................................................
  
  public Sources[][] getDistribution(int rows, int cols, Sources sourceType)
  { 
    Sources[][] distribution = new Sources[rows][cols];
    float offset = random(10000);
    for (int j=0; j<cols; j++)  
    { 
      int ii = int(rows*noise(j*noiseRate + offset));
      for (int i=0; i<rows; i++)
      {
        if (i == ii)  {  distribution[i][j] = sourceType; }
        else  {  distribution[i][j] = NONE; }
      }
    }
    return distribution;
  }
  
  //.....................................................  
}
  
  
// ******************************************************************************