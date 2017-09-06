def setup():
    size(displayWidth, 200)

def draw():
    # Set fill color
    if  mousePressed:
        fill(0)
    else:
        fill(255)
    # Draw the ellipse
    ellipse(mouseX, mouseY, 80, 80)