class Cluster:
    
    # CONSTRUCTOR ............................
    def __init__(self, totalMass, centerOfMass):
        self.totalMass = totalMass
        self.centerOfMass = centerOfMass
        
    #.........................................
    def draw(self):
        position = self.centerOfMass
        mass = self.totalMass/9
        noStroke()
        fill(255-mass/3, 100, mass/3, 50)
        for i in range(10):
            #ellipse(position.x, position.y, 150/(i+1), 150/(i+1))
            ellipse(position.x, position.y, mass/(i+1), mass/(i+1))
        #stroke(0)
        #point(position.x, position.y)