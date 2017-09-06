smiling = False

def setup():
    size(200, 200)
    strokeWeight(4)

def draw():
    background(204)
    
    # DRAW THE EYES
    # If the 'A' key is pressed draw a line
    if (frameCount % 80 < 10):
        line(25, 50, 75, 50)
        line(125, 50, 175, 50)
    else:   # Otherwise, draw an ellipse
        ellipse(50, 50, 50, 50)
        ellipse(150, 50, 50, 50)
    
    # DRAW THE MOUTH
    if (mousePressed):
        ellipse(width/2, 120, 100, 100)
    elif (smiling):
        arc(width/2, 120, 100, 100, 0, PI+QUARTER_PI/2, CHORD)
    else:
        line(width/2-50, 120, width/2+50, 120)
        
def keyPressed():
    if key=='s':
       global smiling
       smiling = not smiling
    