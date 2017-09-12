# Graphs variables
n = 15
nt = 5
period = 50
# Simulation variables
paused = False
step = 0
t = 0

from PTournament import randomPTournament, drawPermutationState, PFactorizingPermuter

permuter = PFactorizingPermuter( randomPTournament( random(2, n) ) )
permutations = []

def setup():
    fullScreen()
    background(100)
    global permutations
    permutations.append(next(permuter))

def draw():
    background(100)
    drawPermutationState( permutations[step] )
    text("Step %d" % step, 100, 100)
    global t
    t +=1

def keyPressed():
    global permutations
    # Reset with a new random tournament
    # when user presses the 'r' key
    if key == 'r' or key == 'R':
        # Reset
        global permuter
        global step
        permuter = PFactorizingPermuter( randomPTournament( random(2, n) ) )
        permutations = [ next(permuter) ]
        step = 0
    # To control the steps of the decomposition
    elif key == CODED:
        global step
        # Move forward with the right arrow
        if keyCode == RIGHT:
            step += 1
            # Check if the step hasn't been computed yet
            if step >= len(permutations):
                try:
                    permutations.append( next(permuter) )
                except StopIteration:
                    pass
                step = len(permutations) - 1
        # Move backwards with the left arrow
        elif keyCode == LEFT:
            if step <= 0:
                step = 0
            else:
                step -=1

from random import randint
def oneIn(n):
    return randint(1,n) == 1