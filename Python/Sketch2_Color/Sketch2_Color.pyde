def setup():
    size(displayWidth, 200)
    colorMode(HSB)

def draw():
    background(255*mouseX/width, 
               255*mouseY/height, 
               255*mouseY/height
               )