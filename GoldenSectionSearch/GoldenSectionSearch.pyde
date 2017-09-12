from Plotter import Plotter

plotter = Plotter() 

def setup():
    fullScreen()
    background(200)
    plotter.setMode("goldenSectionSearch")
    
def draw():
    background(200)
    plotter.showSearch()
    plotter.plot()
    
def keyPressed(k):
    global plotter
    if key == 'f':
        plotter.nextFunction()
    elif key == 'n':
        plotter.advanceSearch()
    elif key == 'r':
        plotter.beginSearch()
    elif key == 's':
        plotter.toogleShadow()