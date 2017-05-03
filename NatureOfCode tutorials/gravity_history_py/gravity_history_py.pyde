from Mover import Mover
from Movers import Movers
from History import History

paintBackground = True
paused = False
drawParticles = True
drawConnections = True
drawClusters = True

maxMass = 400.0
maxVelocity = 10
n_movers = 50
connectedness = 1

temperatureHist = []  
energyHist = []

balls = Movers(n_movers, maxMass, maxVelocity)
history = History(balls, longRun = True)

def setup():
    fullScreen(P2D)
    background(255)
    balls.randomizePosition(width, height)
    history.saveSimulation(balls, connectedness, steps=1000)
    history.drawStep(drawParticles, drawConnections, drawClusters)
    #balls.draw(drawParticles, drawConnections)
    global temperatureHist
    global energyHist
    temperatureHist = [0 for i in range(4*width)]
    energyHist = [0 for i in range(4*width)]
    
def draw():
    if not paused :
        if paintBackground :
            background(255)
        if history.hasNext():
            history.drawStep(drawParticles, drawConnections, drawClusters)
        else:
            history.saveSimulation(balls, connectedness, steps=100)
            history.drawStep(drawParticles, drawConnections, drawClusters)
        #balls.update()
        #balls.draw(drawParticles, drawConnections)
        drawTemperature(balls.temperature())
        #drawEnergy(balls.energy())
        displayFrameRate()
    
#....................................
        
def keyPressed():
    
    global paintBackground
    if key == 'b':
        paintBackground = not paintBackground
        
    global paused
    if key == 'p':
        paused = not paused
        
    global drawParticles
    if key == '1':
        drawParticles = not drawParticles
        
    global drawConnections
    if key == '2':
        drawConnections = not drawConnections
        
    global drawClusters
    if key == '3':
        drawClusters = not drawClusters
        
    if key == 'r':
        history.restartPlayback()
        
    global connectedness
    if key == '+':
        connectedness = 1.25*connectedness
        
    if key == '-':
        connectedness = connectedness/1.25 
        
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
    temperatureHist[frameCount % (4*width)] = temperature*height/maxTemperature 
    noStroke()
    
    for i in range(4*width):
        temperature = temperatureHist[i]
        fillColor = temperature*255/height
        fill(fillColor, 0, 255-fillColor, 100)        
        ellipse(i/4.0, height-temperatureHist[i], 3, 3)
        
#....................................

def drawEnergy(energy):
    maxEnergy = maxVelocity*maxVelocity/(maxMass/4)
    energyHist[frameCount % (4*width)] = energy*height/maxEnergy
    noStroke()
    
    for i in range(4*width):
        energy = energyHist[i]
        fillColor = energy*255/height
        fill(0, 255-fillColor, fillColor)        
        ellipse(i/4.0, height-energy, 5, 5)
    