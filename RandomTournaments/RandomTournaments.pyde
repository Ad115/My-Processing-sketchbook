# Graphs variables
n = 10
nt = 5
period = 50
# Simulation variables
paused = False
t = 0

from PTournament import randomPTournament
tournaments = []

def setup():
    fullScreen()
    background(100)
    
    for i in range(nt):
        tournaments.append( randomPTournament( random(n) ) )

def draw():
    if not paused:
        background(100)
        
        nt = len(tournaments)
        w = width / nt
        for i in range(nt):
            tournament = tournaments[i]
            
            tournament.updatePositions( x = (i+0.5)*w, \
                                        radius = 0.7*w/2, \
                                        angle = (frameCount+ i*i*i) * 0.005 \
                                    )
            tournament.drawSimpleEdges()
            tournament.drawSimpleArrows()
            tournament.drawVertices()
            tournament.drawLabels()
        
            global t
            if oneIn(period) :
                tournament.randomize( random(2, n) )
        t +=1
        
def keyPressed():
    if key == 'p':
        global paused
        paused = not paused
        
from random import randint
def oneIn(n):
    return randint(1,n) == 1
