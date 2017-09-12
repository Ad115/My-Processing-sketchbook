def getNeighborhood(states, site):
    if site == 0:
        return [0] + states[:site+1]
    elif site == len(states)-1:
        return states[site-1:] + [0]
    else:
        return states[site-1:site+1]

def nextStep(states, rule):
    # Auxiliar variable
    possibleNeighborhoods = [[0,0,0], [0,0,1], [0,1,0], [0,1,1], 
                             [1,0,0], [1,0,1], [1,1,0], [1,1,1]]
    # Initialize the result
    newStates = states
    # Traverse the states applying the rule
    for i in range(len(states)):
        # Get the neighbors of this cell
        neighborhood = getNeighborhood(states, i)
        # Calculate the next state according to the rule
        nextState = possibleNeighborhoods.index(neighborhood)
        # Set the next state
        newStates[i] = nextState
    # Finished, return
    return newStates