from Graph import getComponentsFromConnections
from Cluster import Cluster

class Frame:
    
    # Constructor.........................................
    def __init__(self, particles):
        # Save positions
        self.positions = [particles.movers[i].position.copy() for i in range(len(particles.movers))]
        
        # Save velocities
        self.velocities = [particles.movers[i].velocity.copy() for i in range(len(particles.movers))]
        
        # Save whether they are overlapped with another particle
        self.overlapped = [particles.movers[i].closeEncounter for i in range(len(particles.movers))]
        
        # Save whether they are connected with another particle
        self.connections = self.saveConnections(particles)
        
        # Get the clusters from the connections
        self.clusters = self.getClusters(particles)
    
    # ....................................................
    
    def saveConnections(self, particles):
        connections = []
        movers = particles.movers
        for i in range(len(movers)):
            mover = movers[i]
            for ii in range(len(mover.closeTo)):
                closeMover = mover.closeTo[ii]
                j = movers.index(closeMover)
                connections.append({i, j})
        
        return connections
                
    # ....................................................
        
    def draw(self, drawParticles, drawConnections, drawClusters, masses, maxVelocity):
        # Draw clusters
        self.drawClusters(drawClusters)
        
        # Draw connections
        self.drawConnections(drawConnections)
        
        # Draw the particles
        self.drawParticles(drawParticles, masses, maxVelocity)
                
    #.....................................................
    
    def drawParticles(self, drawParticles, masses, maxVelocity):
        n_particles = len(self.positions)
        
        # Draw particles
        if drawParticles:
            for i in range(n_particles):
                # Get important values
                position = self.positions[i]
                velocity = self.velocities[i]
                mass = masses[i]
                isOverlapped = self.overlapped[i]
                
                # Set color
                fillColor = map(velocity.mag(), 0, maxVelocity, 0, 255)
                if isOverlapped:
                    fillColor = color(255, 0, 0)
                fill(fillColor)
                stroke(0)
                
                # Draw the particle
                ellipseMode(CENTER)
                ellipse(position.x, position.y, mass/10, mass/10)
                #point(position.x, position.y)
        
    #.....................................................
    
    def drawConnections(self, drawConnections):
        # Draw connections
        if drawConnections:
            for (i , j) in self.connections:
                firstPosition = self.positions[i]
                secPosition = self.positions[j]
                
                stroke(0, 60)
                line(firstPosition.x, firstPosition.y, secPosition.x, secPosition.y)
    
    # ....................................................

    def update(self, particles):
        # Save positions
        self.positions = [particles.movers[i].position for i in range(len(particles.movers))]
          
        # Save velocities
        self.velocities = [particles.movers[i].velocity for i in range(len(particles.movers))]
        
        # Save whether they are overlapped with another particle
        del self.overlapped[:]
        self.overlapped = [particles.movers[i].closeEncounter for i in range(len(particles.movers))]
            
        # Save whether they are connected with another particle
        self.connections = self.saveConnections(particles)
        
        # Get the clusters from the connections
        self.clusters = self.getClusters(particles)
            
    # .....................................................
    
    def getClusters(self, particles):
        clusters = []
        # Get the connected components
        components = getComponentsFromConnections(self.connections)
    
        # Get the clusters expressed by the connections    
        for component in components:
            # Get the total mass
            totalMass = sum([particles.movers[i].mass for i in component])
            # Get the center of mass
            centerOfMass = PVector(0,0)
            for particle in component:
                mass = particles.movers[particle].mass
                position = particles.movers[particle].position
                centerOfMass.add( PVector.mult(position, mass) )
            centerOfMass.div(totalMass)
            # Assemble a Cluster object that summarizes the previous info
            clusters.append( Cluster(totalMass, centerOfMass) )
            
        # Get the lonely particles also as clusters
        n_particles = len(particles.movers)
        connected = [i for component in components for i in component]
        lonely = [i for i in range(n_particles) if i not in connected]
        for particle in lonely:
                mass = particles.movers[particle].mass
                position = particles.movers[particle].position.copy()
                clusters.append( Cluster(mass, position) )
            
        return clusters
            
    # ...................................................
    
    def drawClusters(self, drawClusters):
        if drawClusters:
            for cluster in self.clusters:
                cluster.draw()