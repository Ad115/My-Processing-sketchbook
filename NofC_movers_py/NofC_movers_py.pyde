from Movers import Movers

wind = PVector(0.01, 0)
gravity = PVector(0, 0.01)
balls = Movers(5)
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
        
#....................................
        
def keyPressed():
    
    global paintBackground
    if key == 'b':
        paintBackground = not paintBackground
        
    global paused
    if key == 'p':
        paused = not paused
    
