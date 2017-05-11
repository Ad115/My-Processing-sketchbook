class Distribution {
  // Variables
  int[] bins;
  int[] freqDist;
  
  // Constructor
  Distribution(int sites) {
    bins = new int[sites];
  }
  
  // Make an experiment
  void experiment(int steps) {
    for (int i=0; i<steps; i++) {
      bins[ int(random(bins.length)) ]++;
    }
  }
  
  // Assemble the frequency distribution
  void assembleFreqDistribution(int size) {
    int n = width/size;
    // Initialize distribution
    if (freqDist == null || freqDist.length != n) {
      freqDist = new int[n];
    }
    // Clear the distribution
    for (int i=0; i<n; i++){
      freqDist[i] = 0;
    }
    // Assemble distribution
    for(int value : bins) {
      if (value < n)
        freqDist[value]++;
    }
  }
  
  // Display the frequency distribution
  void drawDistribution(int r, int g, int b, int op) {
    fill( r, g, b, op );
    stroke(0);
    int n = freqDist.length;
    int w = width/n;
    for (int i=0; i<n; i++){
      rect(i*w, height*0.5-freqDist[i], w, 2*freqDist[i]);
    }
  }
  
  // Display the raw bins data
  void drawBins(int r, int g, int b, int op) {
    stroke( r, g, b, op );
    strokeWeight(1);
    int n_bins = bins.length;
    int w = n_bins/width;
    for (int i=0; i<width; i++){
      int sum = 0;
      for(int j=0; j<w; j++)
        if (i+j < n_bins)
          sum += bins[i+j];
      
      line(i, height/2-sum, i, height/2+sum);
    }
  }
}