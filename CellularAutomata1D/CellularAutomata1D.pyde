from nextStep.py import nextStep
automaton = None
cellSize = 50

def setup():
    fullScreen()
    background(20)
    cellNumber = width/cellSize
    automaton =  