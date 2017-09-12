from random import choice

class Tournament(object):
    """
    Class: Tournament.......................................................................
    A tournament is a directed graph with a simple arc between each vertex
    """
    def __init__(self, adjList=None):
        """
        Initialize a new tournament with an adjacency list
        """
        if adjList == None:
            self.adjList = dict()
        self.update(adjList)

    def __contains__(self, vertex):
        return vertex in self.adjList

    def __str__(self):
        return str(self.adjList)
    
    def __repr__(self):
        return "Tournament(" + str(self.adjList) + ")"

    def update(self, adjList=None):
        """
        Update the inner representation of the structure
        """
        if adjList == None:
            adjList = dict()
        self.adjList = adjList
        # Verify that all vertices are present as keys in the adjacency list
        for v in adjList:
            self.adjList[v] = { u for u in adjList[v] if u in adjList }

    def randomize(self, n=None):
        """
        New tournament on n vertices
        """
        # Check if vertices need to be changed
        if n == None:
            n = len(self.adjList)
        else:
            if n < 1:
                n = 1
            n = int(n)
        # Create a new empty graph (adjacency list)
        adjacencies = { i:set() for i in range(n) }
        for i in range(n):
            for j in range(i+1, n):
                # Check if we must add a (i,j) or a (j,i) edge
                if choice([True, False]):
                    adjacencies[i].add(j)
                else:
                    adjacencies[j].add(i)
        # Make the changes
        self.update(adjacencies)

    def getVertices(self):
        return [v for v in self.adjList]

    def getAdjacencyList(self):
        return self.adjList

    def getOutNeighborhood(self, vertex):
        return self.adjList[vertex]

    def getInNeighborhood(self, vertex):
        g = self.adjList
        return { v for v in g if vertex in g[v] }

# End of class Tournament .............................................

def randomTournament(n=5):
    n = int(n)
    t = Tournament()
    t.randomize(n=n)
    return t

def inducedGraph(tournament, vertices):
    g = tournament.getAdjacencyList()
    return Tournament( { v:g[v] for v in g if v in vertices } )

def getContainingItem(l, query):
    for i in range(len(l)):
        if query in l[i]:
            return [i, l[i]]

def factorizingPermuter(tournament):
    permutation = []
    vertices = tournament.getVertices()
    for i in range( len(vertices)+1 ):
        # On first iteration
        if i == 0:
            permutation.append(tournament)
        else:
            # Get vertex
            v = vertices[i-1]
            # Get the element that contains v
            pos,elem = getContainingItem(permutation, v)
            inNeighbors = elem.getInNeighborhood(v)
            outNeighbors = elem.getOutNeighborhood(v)
            # Prepare to add to the permutation
            sets = [V for V in [inNeighbors, [v], outNeighbors] if V] # Discard empty sets of vertices
            # Add to the permutation
            permutation[pos:pos+1] = [ inducedGraph(elem, V) for V in sets ]
        yield permutation
