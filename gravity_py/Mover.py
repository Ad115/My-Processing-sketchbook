class Mover(object):
    
    # CONSTRUCTOR........................
    
    def __init__(self, maxMass, maxVelocity):
        mass = random(1, maxMass)
        self.mass = mass
        self.size = mass/15
        self.maxVelocity = maxVelocity
        self.closeEncounter = False
        
        self.position = PVector(0,0)
        
        self.velocity = PVector(random(-1, 1),random(-1, 1))
        self.acceleration = PVector(0,0)

    #......................................
                        
    def randomizePosition(self, width, height):
        size = self.size
        x = random(size/2+width/4, 3*width/4-size/2)
        y = random(size/2+ height/4, 3*height/4)
        self.position = PVector(x, y)
        
    #.......................................
        
    def draw(self):
        ellipseMode(CENTER)
        
        fillColor = map(self.velocity.mag(), 0, 10,0, 255)
        if self.closeEncounter:
            fillColor = color(255, 0, 0)
            self.closeEncounter = False
        fill(fillColor)
        
        stroke(0)
        ellipse(self.position.x, self.position.y, self.size, self.size)
        
    #.......................................
    
    def applyForce(self, force):
        effect = PVector.div(force, self.mass)
        self.acceleration.add(effect)
        
    #........................................
    
    def move(self):
        self.velocity.add( self.acceleration )
        self.velocity.limit(self.maxVelocity)
        self.position.add( self.velocity )
        self.acceleration.setMag(0);
        self.bounce()
        
    #..........................................
        
    def bounce(self):
        size = self.size
        # Left
        if self.position.x < 0 + size/2 : 
            self.position.x = 0+size/2 
            self.velocity.x = -self.velocity.x
            
        # Right
        if self.position.x > width - size/2: 
            self.position.x = width - size/2
            self.velocity.x = -self.velocity.x
        
        # Top
        if self.position.y < 0 + size/2 : 
            self.position.y = 0 + size/2
            self.velocity.y = -self.velocity.y
            
        # Botom
        if self.position.y > height - size/2 : 
            self.position.y = height-size/2
            self.velocity.y = -self.velocity.y
            
    #..........................................
    
    def attractMover(self, mover):
        attraction = PVector.sub(self.position, mover.position)
        
        r = attraction.mag()
        if r < self.size:
            self.closeEncounter = True
        constrain(r, size, 30)
        
        attraction.setMag(self.mass * mover.mass / (r*r))
        return attraction;
        
        