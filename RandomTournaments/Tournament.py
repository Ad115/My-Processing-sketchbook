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
        self.adjList = dict()
        self.update(adjList=adjList)

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
        self.update(adjList = adjacencies)

    def getVertices(self):
        return [v for v in self.adjList]

    def getAdjacencyList(self):
        return self.adjList

# End of class Tournament .............................................

def randomTournament(n=5):
    n = int(n)
    t = Tournament()
    t.randomize(n=n)
    return t
