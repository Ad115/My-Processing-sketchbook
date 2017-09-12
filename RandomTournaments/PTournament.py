def positionAt(x0, y0, r, angle):
    x = x0 + r*cos(angle)
    y = y0 + r*sin(angle)
    return x,y

from math import sqrt
def distance(x1, y1, x2, y2):
    dx = x2-x1
    dy = y2-y1
    return sqrt(dx*dx + dy*dy)

from Tournament import randomTournament

class PTournament(object):
    """
    Class: PTournament.......................................................................
    A PTournament is the Processing version of a Tournament.
    It extends the Tournament class to facilitate a graphical interpretation.
    """

    ### INTERPHASE FUNCTIONS.....................................||
    # To interphase with the Tournament class
    def __init__(self, tournament):
        """
        Initialize from existing tournament
        """
        self.tournament = tournament
        self.positions = None # cache the positions every time step
        self.vertices = None # cache the vertices
        self.neighbors = None # cache the adjacency relations
        self.updateState() # Update internal vertices and adjacencies caches

    def update(self, adjList=None):
        """
        Update the inner tournament
        """
        self.tournament.update(adjList)
        self.updateState() # Update internal vertices and adjacencies caches

    def updateState(self):
        """
        Update internal vertices and adjacencies caches
        """
        self.vertices = self.tournament.getVertices()
        self.neighbors = self.tournament.getAdjacencyList()

    def randomize(self, n=None):
        """
        Randomize inner tournament
        """
        self.tournament.randomize(n=n)
        self.updateState()

    ### DRAWING FUNCTIONS.....................................||
    # Processing-only functions to represent the tournament in a graphical way

    def updatePositions(self, x=None, y=None, radius=100, angle=0):
        # Check parameters
        if x == None:
            x = width/2
        if y == None:
            y = height/2
        # Position regularly on a circle at x,y of radius r and with an angle.
        vertices = self.vertices
        n = len( vertices )
        off = TAU / n
        self.positions = { vertices[i] : positionAt(x, y, radius, angle + i*off) \
                           for i in range(n)
                    }

    def drawSimpleEdges(self, x=None, y=None, radius=100, angle=0):
        # Prepare enviroment
        vertices = self.vertices
        neighbors = self.neighbors
        if self.positions == None:
            self.updatePositions(x=x, y=y, radius=radius, angle=angle)
        positions = self.positions
        # Draw edges
        stroke(160)
        strokeWeight(1.5)
        for v in vertices:
            vx,vy = self.positions[v]
            for u in neighbors[v]:
                ux,uy = self.positions[u]
                line(vx, vy, ux, uy)

    def drawSimpleArrows(self, x=None, y=None, radius=100, angle=0, arrow=40):
        # Prepare enviroment
        vertices = self.vertices
        neighbors = self.neighbors
        if self.positions == None:
            self.updatePositions(x=x, y=y, radius=radius, angle=angle)
        positions = self.positions
        # Draw edges
        stroke(220)
        strokeWeight(4)
        for v in vertices:
            vx,vy = self.positions[v]
            for u in neighbors[v]:
                ux,uy = self.positions[u]
                dr = distance(vx, vy, ux, uy)
                f = 1 - arrow/dr
                line(vx + f*(ux-vx), vy + f*(uy-vy), ux, uy)

    
    def drawLabels(self, x=None, y=None, radius=100, angle=0, size=20, font=None):
        # Prepare enviroment
        if font != None:
            textFont(font)
        vertices = self.vertices
        if self.positions == None:
            self.updatePositions(x=x, y=y, radius=radius, angle=angle)
        positions = self.positions
        # Draw labels
        textAlign(CENTER, CENTER)
        textSize(size)
        fill(255)
        for v in vertices:
            vx,vy = self.positions[v]
            text(str(v), vx, vy)
            
    def drawVertices(self, x=None, y=None, radius=100, angle=0, size=30):
        # Prepare enviroment
        vertices = self.vertices
        if self.positions == None:
            self.updatePositions(x=x, y=y, radius=radius, angle=angle)
        positions = self.positions
        # Draw vertices
        ellipseMode(CENTER)
        fill(160)
        for v in vertices:
            vx,vy = self.positions[v]
            ellipse(vx, vy, size, size)

# End of class PTournament .............................................

def randomPTournament(n=5):
    return PTournament( randomTournament(n) )
