from ComplexUtils import *
from JuliaFunctions import *
c = (-0.1, 0.65)

def setup():
    fullScreen(FX2D)
    #background(20, 10, 20)
    background(10)
    ellipseMode(CENTER)
    noStroke()
    
    # Perturb c, the polinomial constant, to get a different image each time
    global c; 
    c = complexPerturbation(c, 0.005)
    
def draw():
    # Display the framerate (must be <30 or things will look slow)
    showText("Framerate : %d" % frameRate)
    
    # Bubble effect
    bubbleFrames = 100
    if frameCount < bubbleFrames:
        bubble = 1.5/bubbleFrames * frameCount
    else:
        bubble = 1.5
    # Calculate and plot 100 dots each frame
    maxIterations = 250
    for i in range(100):
        # Calculations
        global c
        c = complexPerturbation(c, 0.000005)
        z = complexRandomPolar(bubble)
        n = iterationsToGo(z, c, maxIterations)
        
        # Prepare to plot
        x, y = toScreenCoords(z, 1.5)
        if n < 10:
            fillColor = 1-(z[0]**2 + z[1]**2)/2.25
            fill( fillColor * 50, 0, fillColor * 150) # alpha 70
            stroke( fillColor * 50, 0, fillColor * 150) # alpha 70 
        else:
            fillColor = 255 * ( (n-1) / maxIterations ) # Map from 1 to 101 to a grayscale(0-255)
            #fillColor = n/2
            #fill(fillColor, 70)
            fill( fillColor, 200*(fillColor/200)**3, 120 + fillColor/3.5)
            stroke( fillColor, 200*(fillColor/200)**3, 120 + fillColor/3.5)
                                    
        # Plot
        r = 3
        #ellipse(x, y, r, r)
        point(x,y)
        #Plot c
        cx, cy = toScreenCoords(c, 1.5)
        fill(255, 200, 0, 70)
        ellipse(cx, cy, r, r)
    
def keyPressed():
    # User reset
    if key == 'r':
        global c
        c = (-0.1, 0.65)
    # User perturbation of c
    if key == 'p':
        global c
        c = complexPerturbation(c, 0.05)
        
def showText(daText, x=100, y=100):
    fill(20)
    rect(100, 100-(textAscent() + textDescent()), 
         textWidth(daText)+4, textAscent()+4)
    fill(200)
    text(daText, 100, 100)
    
def toScreenCoords(vector, radius):
    scaling = (height / radius)*0.8
    x = scaling * vector[0] + width/2 # Scale and displace origin
    y = -(scaling * vector[1]) + height/2 # Here turn the y axis the right way
    return x, y