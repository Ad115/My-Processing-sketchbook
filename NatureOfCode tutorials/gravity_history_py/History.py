from Frame import Frame

class History:
    
    # CONSTRUCTOR.........................
    def __init__(self, particles, longRun = False):
        # Save particle properties
        self.maxMass = particles.movers[0].maxMass
        self.maxVelocity = particles.movers[0].maxVelocity
        self.masses = [particles.movers[i].mass for i in range(len(particles.movers))]
        self.longRun = longRun # To toogle saving history (useful for long, continuous runs)
        
        if longRun:
            self.frames = Frame(particles)
        else:
            self.frames = []
        self.currentFrameNo = 0
        
    #.....................................
    def addFrame(self, frame):
        self.frames.append(frame)
        
    #.....................................
    def saveFrame(self, particles):
        currentFrame = Frame(particles)
        self.addFrame(currentFrame)
    
    #.....................................
    def saveSimulation(self, particleSystem, connectedness, steps=100):
        if self.longRun:
            particleSystem.update(connectedness)
            self.frames.update(particleSystem)
        else:
            self.saveFrame(particleSystem)
            for i in range(steps):
                particleSystem.update(connectedness)
                self.saveFrame(particleSystem)
            
    #.....................................
    def hasNext(self):
        if self.longRun:
            return False
        else:
            return ( self.currentFrameNo+1 < len(self.frames) )
    
    #.....................................
    def drawStep(self, drawParticles, drawConnections, drawClusters):
        if self.longRun:
            frame = self.frames
        else:
            frame = self.frames[self.currentFrameNo]
            self.currentFrameNo = self.currentFrameNo + 1
            
        frame.draw(drawParticles, drawConnections, drawClusters, self.masses, self.maxVelocity)            
        
    #.....................................
    def restartPlayback(self):
        self.currentFrameNo = 0