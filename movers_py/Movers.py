from Mover import Mover

class Movers(object):
    
    # CONSTRUCTOR...................................
    def __init__(self, n_movers):
        self.n_movers = n_movers
        self.movers = [ Mover() for i in range(n_movers) ]
    
    #................................................
    def randomizePosition(self):
        for mover in self.movers:
            mover.randomizePosition()
            
    #................................................
    def draw(self):
        for mover in self.movers:
            mover.draw()
            
    #................................................
    def update(self):
        for mover in self.movers:
            mover.update()
        