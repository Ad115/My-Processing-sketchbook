def setup():
    size(displayWidth, 200)
    stroke(100)

def draw():
    line(width/2, height/2, mouseX, mouseY)
    
def mousePressed():
    background( random(255) )