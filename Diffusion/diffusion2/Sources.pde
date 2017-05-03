enum Sources
{
  SOURCE
  {
    Sources add(Sources other)
    {
      if(other == SINK)  {  return NONE; }  else {  return this; }
    }
  },
  
  //.....................................................
   
  SINK
  {
    Sources add(Sources other)
    {
      if(other == SOURCE)  {  return NONE; }  else {  return this; }
    }
  },
  
  //.....................................................
  
  NONE
  {
    Sources add(Sources other)  {  return other; }
  };
  
  //.....................................................
  
  abstract Sources add(Sources other);
  
  //.....................................................
}

final Sources SOURCE = Sources.SOURCE;
final Sources SINK = Sources.SINK;
final Sources NONE = Sources.NONE;


// ******************************************************************************


abstract class SourceDistribution
{ 
  int rows, cols;
  Sources[][] distribution;
  
  //.....................................................
  
  abstract Sources[][] getDistribution(int rows, int cols, Sources sourceType);
  
  //.....................................................
  
  SourceDistribution init(int rows, int cols, Sources sourceType)
  {
    this.rows = rows;
    this.cols = cols;

    this.distribution = getDistribution(rows, cols, sourceType);
    return this;
  }
    
  
  void add(SourceDistribution other)
  {
    for (int i=0; i<rows; i++)
    { for (int j=0; j<cols; j++)
      {
        Sources local = this.at(i, j);
        distribution[i][j] = local.add( other.at(i, j) );
      }
    }
  }
  
  //.....................................................
  
  Sources at(int i, int j)  {  return distribution[i][j]; }
  
  //.....................................................
}


// ******************************************************************************


class SourcesAtTOP extends SourceDistribution
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


class SourcesAtBOTTOM extends SourceDistribution
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


class SourcesAtCIRCLE extends SourceDistribution
{
  float relativeRadius;
  boolean randomRadius = true;
  
  SourcesAtCIRCLE()  {  randomRadius = true; }
  
  SourcesAtCIRCLE(float relativeRadius)  {  this.relativeRadius = relativeRadius; }
  
  //.....................................................
  
  public Sources[][] getDistribution(int rows, int cols, Sources sourceType)
  { 
    Sources[][] distribution = new Sources[rows][cols];
    float maxRadius = (rows < cols) ? rows/2 : cols/2;
    if (randomRadius)  {  relativeRadius = random(1); }
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


class SourcesAtCENTER extends SourceDistribution
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
  
  
class SourcesAtRANDOM extends SourceDistribution
{
  float probability = 0.1;
  
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
  
  
class SourcesAtNOISE_VERTICAL extends SourceDistribution
{
  float noiseRate = 0.005;
  
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
  
  
class SourcesAtNOISE_HORIZONTAL extends SourceDistribution
{
  float noiseRate = 0.005;
  
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