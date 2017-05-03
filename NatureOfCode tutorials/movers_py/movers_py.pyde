from Mover import Mover
from Movers import Movers

balls = Movers(50)
paintBackground = True
paused = False


def setup():
    fullScreen()
    background(255)
    balls.randomizePosition()
    balls.draw()
    
def draw():
    if not paused :
        if paintBackground :
            background(255)
        balls.update()
        balls.draw()
        displayFrameRate()
        
#....................................
        
def keyPressed():
    
    global paintBackground
    if key == 'b':
        paintBackground = not paintBackground
        
    global paused
    if key == 'p':
        paused = not paused
        
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