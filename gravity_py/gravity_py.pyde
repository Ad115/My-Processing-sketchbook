from Mover import Mover
from Movers import Movers

paintBackground = True
paused = False
draw = True
maxMass = 400.0
maxVelocity = 10.0
temperatureHist = []  
energyHist = []

balls = Movers(5, maxMass, maxVelocity)

def setup():
    fullScreen()
    background(255)
    balls.randomizePosition(width, height)
    if draw:
        balls.draw()
    global temperatureHist
    global energyHist
    temperatureHist = [0 for i in range(width)]
    energyHist = [0 for i in range(width)]
    
def draw():
    if not paused :
        if paintBackground :
            background(255)
        balls.update()
        if draw:
            balls.draw()
        drawTemperature(balls.temperature())
        drawEnergy(balls.energy())
        displayFrameRate()
    
#....................................
        
def keyPressed():
    
    global paintBackground
    if key == 'b':
        paintBackground = not paintBackground
        
    global paused
    if key == 'p':
        paused = not paused
        
    global draw
    if key == 'd':
        draw = not draw
        
    if key == 'r':
      setup()  
        
#.....................................
        
def displayFrameRate():
    framerateText = "Frame rate: " + str(frameRate)
    fill(200)
    textSize(24)
    rectMode(CORNER)
    text_width = textWidth(framerateText)
    rect(0, 0, text_width+10, 30)
    fill(0)
    text(framerateText, 10, 24)
    
#....................................

def drawTemperature(temperature):
    maxTemperature = maxVelocity * maxVelocity
    temperatureHist[frameCount % width] = temperature*height/maxTemperature 
    noStroke()
    
    for i in range(width):
        temperature = temperatureHist[i]
        fillColor = temperature*255/height
        fill(fillColor, 0, 255-fillColor)        
        ellipse(i, height-temperature, 5, 5)
        
#....................................

def drawEnergy(energy):
    maxEnergy = maxVelocity*maxVelocity/maxMass
    energyHist[frameCount % width] = energy*height/maxEnergy
    noStroke()
    
    for i in range(width):
        energy = energyHist[i]
        fillColor = energy*255/height
        fill(fillColor/4, fillColor, fillColor/2)        
        ellipse(i, height-energy, 5, 5)
    