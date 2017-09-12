from ComplexUtils import *
from Examen import complexPol, iterationsToGo, author
c = (-0.1, 0.65)

# Main functions ------------------------------------------------------------

def setup():
    fullScreen(FX2D)
    background(10)
    ellipseMode(CENTER)
    noStroke()
    
    # Perturb c, the polinomial constant, to get a different image each time
    global c; 
    c = complexPerturbation(c, 0.05)
    print("c = " + str(c))
    
    
def draw():
    # Display the framerate (must be <30 or things will look slow)
    #showText("Framerate : %d" % frameRate) 
    # Display the name of the author
    showText(author)
    
    # Bubble size and dot size
    dotSize = 2
    bubble = 1.5
    
    # Calculate and plot 100 dots each frame
    for i in range(150):
        # Calculations
        global c
        #c = complexPerturbation(c, 0.000005)
        z = complexRandomPolar(bubble)
        n = iterationsToGo(z, c, complexPol)
        
        # Prepare to plot
        maxIterations = 250
        x, y = toScreenCoords(z, 1.5) # Transform complex coordinates to positions in the screen
        if n < 10: # Is n large?
            fillColor = 1-(z[0]**2 + z[1]**2)/2.25 # Dark fill according to position
            fill( fillColor * 50, 0, fillColor * 150, 100) # alpha 70
        else:
            fillColor = 255 * ( (n-1) / maxIterations ) # Map from 1 to 101 to a grayscale(0-255)
            fill( fillColor, 200*(fillColor/200)**3, 120 + fillColor/3.5, 100) # Preety (maybe arbitrary) RGB color
                                    
        # Plot the dot
        ellipse(x, y, dotSize, dotSize)
        
        # Export the 3000th frame
        if frameCount == 3000:
            print("Saving to file")
            saveFrame(author + "-Julia-Python.png")
            exit() # Finished, close the program
            
# Helper functions.............................................

def keyPressed():
    # User reset
    if key == 'r':
        global c
        c = (-0.1, 0.65)
    # User perturbation of c
    if key == 'p':
        global c
        c = complexPerturbation(c, 0.05)
        
        
def showText(daText, x=40, y=40):
    """
    Prints text `daText` to the screen with top left
    corner at screen coordinates `x` and `y`. 
    """
    # Calculate the dimensions of the printed text to paint a background around it
    bgWidth = textWidth(daText)+4
    bgHeight = textAscent()+4
    bgX = x
    bgY = y-(textAscent() + textDescent())
    
    # Set fill color and draw the background  
    fill(10)
    rect(bgX, bgY, bgWidth, bgHeight)
    
    # Set text color and print the text
    fill(100)
    text(daText, x, y)
   
     
def toScreenCoords(vector, radius):
    """ 
    Transforms the 2D vector `vector` of magnitude <= `radius` into 
    coordinates in the screen.
    
    The coordinates in the screen are:
        - Top left corner: 0, 0
        - Top right corner: width, 0
        - Bottom left corner:  0, height
        - Bottom right corner: width, height
        
    What we want is: 
        1. To fit (more or less) the circle of radius `radius` in the screen,
           so we add a scaling factor of ~(height / 2 radius).
        2. We want the `y` axis to increase upwards, so we flip the scaled `y` coordinate
           multiplying by -1
        3. We want the point (0, 0) to be in the middle of the screen, so we translate
           the resulting coordinates by adding the vector (width/2, height/2), so everything
           is relative to that point
    """
    # First, the complex numbers are in of radius ~ 1.5, so
    scaling = ( height/(2*radius) ) * 1.4
    x = scaling * vector[0] + width/2 # Scale and displace origin
    y = -(scaling * vector[1]) + height/2 # Here turn the y axis the right way
    return x, y # The screen coordinates of the vector